//
//  ViewController.swift
//  UIAlert
//
//  Created by Yilin on 2019/7/26.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func alert(_: UIButton) {
        let myAlert = UIAlertController(title: "Hello", message: "Hello World", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "OK", style: .default) {
            (_: UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        let sayHelloAction = UIAlertAction(title: "Say Hello", style: .destructive) {
            (_: UIAlertAction) in
            print("hello")
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            (_: UIAlertAction) in
            print("cancel")
            self.dismiss(animated: true, completion: nil)
        }
        myAlert.addAction(okAction)
        myAlert.addAction(sayHelloAction)
        myAlert.addAction(cancelAction)
        present(myAlert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
