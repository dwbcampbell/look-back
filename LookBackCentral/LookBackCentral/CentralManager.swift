//
//  CentralManager.swift
//  LookBackCentral
//
//  Created by Douglas Campbell on 2018-05-05.
//  Copyright © 2018 dwbcampbell. All rights reserved.
//

import Foundation
import CoreBluetooth

class CentralManager :  NSObject, CBCentralManagerDelegate, CBPeripheralDelegate
{
    static let shared = CentralManager()
    
    var manager: CBCentralManager!
    var peripherals: [CBPeripheral] = [CBPeripheral]()
    
    private override init() {
        super.init()
        manager = CBCentralManager(delegate: self, queue: nil)
    }
    
    // MARK: CBCentralManagerDelegate
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
        case .resetting:
            print("central.state is .resetting")
        case .unsupported:
            print("central.state is .unsupported")
        case .unauthorized:
            print("central.state is .unauthorized")
        case .poweredOff:
            print("central.state is .poweredOff")
        case .poweredOn:
            print("central.state is .poweredOn")
            central.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber) {
        print("Peripheral discovered \(peripheral.name ?? "unknown")")
        for (key, value) in advertisementData {
            print("Peripheral: \(key) \(value)")
        }
        
        if let manufacturerData = advertisementData["kCBAdvDataManufacturerData"] {
            print(manufacturerData)
        }
        
        self.peripherals.append(peripheral)
        peripheral.delegate = self
        central.connect(peripheral, options: nil)
        
        central.stopScan()
    }
    
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("peripheral connected \(peripheral.name ?? "unknown")")
        peripheral.discoverServices(nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Peripheral disconnected")
    }
    
    // MARK: CBPeripheralDelegate
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {
            return
        }
        
        for service in services {
            print("Service: \(service)")
            if let characteristics = service.characteristics {
                for characteristic in characteristics {
                    print("Characteristic:\(characteristic)")
                }
            }
            if let included = service.includedServices {
                for incl in included {
                    print("Included Service: \(incl)")
                }
            }
        }
    }
}
