//
//  ViewController.swift
//  HelloTabBarAgain
//
//  Created by Yilin on 2019/7/28.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var myLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        myLabel.text = "first view"

        if let secondViewController = self.tabBarController?.viewControllers?[1] as? NewViewController {
            secondViewController.messageFromViewOne = "Hi"
        }
    }
}
