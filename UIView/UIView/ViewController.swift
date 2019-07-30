//
//  ViewController.swift
//  UIView
//
//  Created by User on 26/7/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var container: UIView!
    @IBOutlet var mySwitch: UISwitch!

    @IBAction func alert(_: UIButton) {
        let myAlert = UIAlertController(title: "Hello", message: "How are you?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {
            (_: UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        let helloAction = UIAlertAction(title: "Say Hello", style: .default) {
            (_: UIAlertAction) in
            self.dismiss(animated: true) {
                self.myLabel.text = "hello world"
            }
        }
        myAlert.addAction(okAction)
        myAlert.addAction(helloAction)
        present(myAlert, animated: true)
    }

    @IBOutlet var myLabel: UILabel!
    @IBAction func sliderChange(_ sender: UISlider) {
        myLabel.text = "\(sender.value)"
    }

    @IBAction func myToggleChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            view.backgroundColor = .red
        case 1:
            view.backgroundColor = .yellow
        case 2:
            view.backgroundColor = .purple
        case 3:
            view.backgroundColor = .blue
        case 4:
            view.backgroundColor = .green
        default:
            view.backgroundColor = .white
        }
    }

    @IBAction func makeAChange(_ sender: UISwitch) {
        if sender.isOn {
            print("it's on")
            view.backgroundColor = .white
        } else {
            print("it's off")
            view.backgroundColor = .black
        }
    }

    @objc func codeSwitchChange(_ sender: UISwitch) {
        if sender.isOn {
            print("it's on")
            view.backgroundColor = .white
        } else {
            print("it's off")
            view.backgroundColor = .black
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // manually create UIView
        let viewArea = CGRect(x: 50, y: 400, width: 100, height: 50)
        let smallRect = UIView(frame: viewArea)
        smallRect.backgroundColor = .purple

        container.addSubview(smallRect)

        mySwitch.isOn = true
        makeAChange(mySwitch)

        // manually create UISwitch
        let codeSwitch = UISwitch(frame: CGRect(x: view.frame.midX - 51 / 2, y: view.frame.maxY - 100, width: 51, height: 31))
        codeSwitch.isOn = true
        codeSwitch.addTarget(self, action: #selector(ViewController.codeSwitchChange(_:)), for: .valueChanged)
        view.addSubview(codeSwitch)
    }
}
