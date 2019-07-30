//
//  ViewController.swift
//  NumberLock
//
//  Created by Yilin on 2019/7/25.
//  Copyright © 2019 Yilin. All rights reserved.
//

import GameKit
import UIKit

class ViewController: UIViewController {
//    var minNumber = 1
//    var maxNumber = 100
//    var answer = GKRandomSource.sharedRandom().nextInt(upperBound: 100) + 1
//    var isGameOver = false

    var minNumber: Int = 0
    var maxNumber: Int = 0
    var answer: Int = 0
    var isGameOver: Bool = false

    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var background: UIImageView!

    @IBAction func makeAGuest(_: UIButton) {
        if isGameOver {
            resetGame()
        } else {
            // playing game
            var message = getMessage(minNumber: minNumber, maxNumber: maxNumber)
            messageLabel.text = message

            let inputText = inputTextField.text!
            let inputNumber = Int(inputText)

            inputTextField.text = ""
            if inputNumber == nil {
                messageLabel.text = "No input! " + message
            } else {
                if inputNumber! > 100 {
                    messageLabel.text = "Too large! " + message
                } else if inputNumber! < 1 {
                    messageLabel.text = "Too small! " + message
                } else if inputNumber! == answer {
                    messageLabel.text = "Bingo! Please press [Guess] to play again!"
                    isGameOver = true
                    background.image = UIImage(named: "Finish")
                } else {
                    if inputNumber! > answer {
                        maxNumber = inputNumber!
                    } else {
                        minNumber = inputNumber!
                    }
                    message = getMessage(minNumber: minNumber, maxNumber: maxNumber)
                    messageLabel.text = "Try again! " + message
                }
            }
        }
    }

    func resetGame() {
        minNumber = 1
        maxNumber = 100
        answer = GKRandomSource.sharedRandom().nextInt(upperBound: maxNumber) + 1
        isGameOver = false
        messageLabel.text = getMessage(minNumber: minNumber, maxNumber: maxNumber)
        background.image = UIImage(named: "BG")
    }

    func getMessage(minNumber: Int, maxNumber: Int) -> String {
        return "Guess a Number \(minNumber) ~ \(maxNumber)"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // inputTextField.becomeFirstResponder()
        resetGame()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
