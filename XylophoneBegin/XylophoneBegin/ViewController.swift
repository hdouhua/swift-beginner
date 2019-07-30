//
//  ViewController.swift
//  XylophoneBegin
//
//  Created by Yilin on 2019/7/28.
//  Copyright © 2019 Yilin. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    var audioMetrics: [AVAudioPlayer?] = [AVAudioPlayer?]()

    @IBAction func playSound(_ sender: UIButton) {
        let player = audioMetrics[sender.tag]
        player?.stop()
        player?.currentTime = 0.0
        player?.play()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0 ... 7 {
            guard let path = Bundle.main.path(forResource: "\(i + 1)", ofType: "mp3") else {
                audioMetrics.append(nil)
                return
            }
            let url = URL(fileURLWithPath: path)

            do {
                audioMetrics.append(try AVAudioPlayer(contentsOf: url))
            } catch {
                audioMetrics.append(nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
