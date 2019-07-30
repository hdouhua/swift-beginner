//
//  ViewController.swift
//  HelloPlayAudio
//
//  Created by Yilin on 2019/7/26.
//  Copyright © 2019 Yilin. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    var audioPlayer: AVAudioPlayer?

    @IBAction func play(_: UIButton) {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
        audioPlayer?.play()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // find audio path
        if let path = Bundle.main.path(forResource: "Right", ofType: "mp3") {
            // get audio URL
            let url = URL(fileURLWithPath: path)

            // make an audio player
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.enableRate = true
                audioPlayer?.rate = 2.5
                audioPlayer?.numberOfLoops = 3
                audioPlayer?.volume = 1.5
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("audio cannot find")
        }
    }
}
