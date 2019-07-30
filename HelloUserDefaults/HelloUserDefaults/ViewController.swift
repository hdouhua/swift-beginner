//
//  ViewController.swift
//  HelloUserDefaults
//
//  Created by Yilin on 2019/7/28.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // save info to userdefaults
//        UserDefaults.standard.set("dao", forKey: "name")

        // load info from userdefaults
        if let name = UserDefaults.standard.value(forKey: "name") as? String {
            print("Hello \(name)")
        }
    }
}
