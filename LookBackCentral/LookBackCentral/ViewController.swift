//
//  ViewController.swift
//  LookBackCentral
//
//  Created by Douglas Campbell on 2018-05-04.
//  Copyright © 2018 dwbcampbell. All rights reserved.
//

import Cocoa
import AVKit
import AVFoundation


class ViewController: NSViewController {

    @IBOutlet weak var playerView: AVPlayerView!
    
    var centralManager: CentralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movieURL = Bundle.main.url(forResource: "9", withExtension: "mp4") else {
            return
        }
        
        let player = AVPlayer(url: movieURL)
        playerView.player = player
        
        if let currentItem =  player.currentItem {
            print("Can reverse \(currentItem.canPlayReverse)")
        }
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                               object: self.playerView.player!.currentItem,
                                               queue: .main)
        { _ in
            if let currentItem =  player.currentItem {
                print("Can reverse \(currentItem.canPlayReverse)")
                if currentItem.canPlayReverse {
                    self.playerView.player!.rate = -1.0
                }
                else {
                    self.playerView.player!.seek(to: kCMTimeZero)
                }
            }
            
            //self.playerView.player!.play()
        }
        
        self.centralManager = CentralManager.shared
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

