//
//  ViewController.swift
//  LookBackPeripheral
//
//  Created by Douglas Campbell on 2018-05-04.
//  Copyright © 2018 dwbcampbell. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let movieURL = Bundle.main.url(forResource: "9", ofType: "mp4")!
        let player = AVPlayer(url: movieURL)
        playerView.player = player
        playerView.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

