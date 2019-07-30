//
//  ViewController.swift
//  Protocol
//
//  Created by Yilin on 2019/7/26.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let numberArray = ["1", "2", "3", "4", "5", "6", "7", "8"]
    let fruitArray = ["apple", "watermelon", "banana"]

    func numberOfComponents(in _: UIPickerView) -> Int {
        // how many component in picker view
        return 2
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // how many row in a pickerview component
        if component == 0 {
            return numberArray.count
        } else {
            return fruitArray.count
        }
    }

    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return numberArray[row]
        } else {
            return fruitArray[row]
        }
    }

    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            print("number: \(numberArray[row])")
        } else {
            print("fruit: \(fruitArray[row])")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
