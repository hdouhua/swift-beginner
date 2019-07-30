//
//  ViewController.swift
//  FortuneTeller
//
//  Created by Yilin on 2019/7/26.
//  Copyright © 2019 Yilin. All rights reserved.
//

import AudioToolbox
import GameKit
import UIKit

class ViewController: UIViewController {
    @IBOutlet var yourFortune: UIImageView!

    @IBAction func changeFortune(_: UIButton) {
        showAnswer()
    }

    // shake to play
    override func motionEnded(_: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == .motionShake {
            showAnswer()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        yourFortune.isHidden = true
    }

    func showAnswer() {
        if yourFortune.isHidden {
            // show me answer
            // let answer = GKRandomSource.sharedRandom().nextInt(upperBound: 6) + 1
            let answer = Int.random(in: 1 ... 6)
            yourFortune.image = UIImage(named: "\(answer)")
            yourFortune.isHidden = false

            AudioServicesPlaySystemSound(1111)
        } else {
            // hide the answer
            yourFortune.isHidden = true
        }
    }
}
