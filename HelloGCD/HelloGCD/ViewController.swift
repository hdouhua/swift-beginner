//
//  ViewController.swift
//  HelloGCD
//
//  Created by User on 29/7/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let task1 = {
            for i in 1 ... 5 {
                print("task1: \(i)")
            }
        }

        let task2 = {
            for i in 1 ... 5 {
                print("task2: \(i)")
            }
        }

//        // put the task related with GUI
//        DispatchQueue.main.async(execute: task1)
//        DispatchQueue.main.async(execute: task2)

        // put
        DispatchQueue.global().async(execute: task1)
        DispatchQueue.global().async(execute: task2)
    }
}
