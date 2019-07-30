//
//  ViewController.swift
//  test01
//
//  Created by User on 25/7/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var myTitle: UILabel!

    @IBAction func buttonPress(_: UIButton) {
        print("what's up")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
