//
//  Library.swift
//  PAD
//
//  Created by Joy Hsu on 11/27/16.
//  Copyright © 2016 Joy Hsu. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer
import CareKit


import UIKit
import AVKit
import AVFoundation

class Library: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //playVideo()
    }
    
    @IBAction func playVideo() {
        guard let path = Bundle.main.path(forResource: "PAD", ofType:"mp4") else {
            debugPrint("video.mp4 not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }
}
