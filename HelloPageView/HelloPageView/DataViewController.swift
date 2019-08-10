//
//  DataViewController.swift
//  HelloPageView
//
//  Created by User on 30/7/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    @IBOutlet var dataLabel: UILabel!
    var dataObject: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataLabel!.text = dataObject
    }
}
