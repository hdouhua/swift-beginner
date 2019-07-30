//
//  ViewController.swift
//  PrimeNumber
//
//   Created by User on 26/7/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func doThePrimeTest(_: UIButton) {
//        // 1) take out the number string from inputTextField
//        if let inputText = inputTextField.text {
//            // 2) convert the number string to int
//            if let inputNumber = Int(inputText) {
//                // 3) checkPrime to get result
        ////                resultLabel.text = checkPrime(num: inputNumber)
        ////                resultLabel.isHidden = false
//
        ////                checkPrime(num: inputNumber, completedHandler: { (result: String) in
        ////                    resultLabel.text = result
        ////                    resultLabel.isHidden = false
        ////                })
//
//                checkPrime(num: inputNumber) {
//                    resultLabel.text = $0
//                    resultLabel.isHidden = false
//                }
//            }
//        }

        // 1) take out the number string from inputTextField
        // 2) convert the number string to int
        if let inputText = inputTextField.text, let inputNumber = Int(inputText) {
            // 3) checkPrime to get result
            checkPrime(num: inputNumber) {
                resultLabel.text = $0
                resultLabel.isHidden = false
            }
        } else {
            resultLabel.text = "please enter a Number"
            resultLabel.isHidden = false
        }

        inputTextField.text = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inputTextField.becomeFirstResponder()
    }

    func checkPrime(num inputNumber: Int) -> String {
        var isPrime: Bool? = true

        if inputNumber <= 0 {
            isPrime = nil
        } else if inputNumber == 1 {
            isPrime = false
        } else {
            for i in 2 ..< inputNumber {
                if inputNumber % i == 0 {
                    isPrime = false
                    break
                }
            }
        }

        if isPrime == true {
            return "\(inputNumber) is prime"
        } else if isPrime == false {
            return "\(inputNumber) is not prime"
        } else {
            return "please enter a Number > 0"
        }
    }

    func checkPrime(num inputNumber: Int, completedHandler handler: (String) -> Void) {
        handler(checkPrime(num: inputNumber))
    }
}
