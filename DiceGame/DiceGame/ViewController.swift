//
//  ViewController.swift
//  DiceGame
//
//  Created by Yilin on 2019/8/1.
//  Copyright © 2019 Yilin. All rights reserved.
//

import AudioToolbox
import UIKit

class ViewController: UIViewController {
    let count: UInt32 = 6

    @IBOutlet var leftDiceImage: UIImageView!
    @IBOutlet var rightDiceImage: UIImageView!
    @IBOutlet var label: UILabel!

    @IBAction func roll(_: UIButton) {
        rollAction()
    }

    func rollAction() {
        let num1 = arc4random_uniform(count) + 1
        let num2 = arc4random_uniform(count) + 1

        AudioServicesPlaySystemSound(1111)
        
        leftDiceImage.image = UIImage(named: "Dice\(num1)")
        rightDiceImage.image = UIImage(named: "Dice\(num2)")
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with _: UIEvent?) {
        if motion == .motionShake {
            rollAction()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        rollAction()
    }
}
