//
//  ViewController.swift
//  Calculator
//
//  Created by Yilin on 2019/7/30.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

enum OperationType {
    case add
    case subtract
    case multiply
    case divide
    case none
}

class ViewController: UIViewController {
    var numberOnScreen: Double = 0
    var previousNumber: Double = 0
    var operation: OperationType = .none
    var calculating = false
    var answered = false

    @IBOutlet var myLabel: UILabel!

    @IBAction func clear(_: UIButton) {
        myLabel.text = "0"
        numberOnScreen = 0
        previousNumber = 0
        operation = .none
        calculating = false
        answered = false
    }

    @IBAction func numbers(_ sender: UIButton) {
        let inputNumber = sender.tag - 1

        if answered {
            clear(sender)
        }

        if myLabel.text != nil {
            if myLabel.text! == "0" {
                myLabel.text = "\(inputNumber)"
            } else {
                myLabel.text = "\(myLabel.text!)\(inputNumber)"
            }
        }

        numberOnScreen = numberOnScreen * 10 + Double(inputNumber)
    }

    @IBAction func divide(_: UIButton) {
        myLabel.text = myLabel.text! + "/"
        operation = .divide
        calculating = true
        answered = false
        previousNumber = numberOnScreen
        numberOnScreen = 0
    }

    @IBAction func multiply(_: UIButton) {
        myLabel.text = myLabel.text! + "x"
        operation = .multiply
        calculating = true
        answered = false
        previousNumber = numberOnScreen
        numberOnScreen = 0
    }

    @IBAction func subtract(_: UIButton) {
        myLabel.text = myLabel.text! + "-"
        operation = .subtract
        calculating = true
        answered = false
        previousNumber = numberOnScreen
        numberOnScreen = 0
    }

    @IBAction func add(_: UIButton) {
        myLabel.text = myLabel.text! + "+"
        operation = .add
        calculating = true
        answered = false
        previousNumber = numberOnScreen
        numberOnScreen = 0
    }

    @IBAction func answer(_: UIButton) {
        if calculating {
            var result: Double = 0
            switch operation {
            case .add:
                result = previousNumber + numberOnScreen
            case .subtract:
                result = previousNumber - numberOnScreen
            case .multiply:
                result = previousNumber * numberOnScreen
            case .divide:
                result = previousNumber / numberOnScreen
            case .none:
                myLabel.text = "0"
            }

            myLabel.text = "\(result)"
            answered = true
            calculating = false
            numberOnScreen = result
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
