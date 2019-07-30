//
//  SecondViewController.swift
//  ToDoList
//
//  Created by Yilin on 2019/7/28.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    var infoFromViewTwo: Int?

    @IBOutlet var myInputText: UITextField!
    @IBOutlet var myButton: UIButton!

    @IBAction func inputTextChanged(_ sender: UITextField) {
        if sender.text != "" {
            myButton.setTitle("OK", for: .normal)
        } else {
            myButton.setTitle("Back", for: .normal)
        }
    }

    @IBAction func buttonPress(_: UIButton) {
        addToDos()
    }

    func textFieldShouldReturn(_: UITextField) -> Bool {
        addToDos()
        return true
    }

    func addToDos() {
        if let text = myInputText.text {
            if text != "" {
                if let firstViewController = tabBarController?.viewControllers?[0] as? FirstViewController {
                    if infoFromViewTwo != nil {
                        firstViewController.toDos[infoFromViewTwo!] = text
                    } else {
                        firstViewController.toDos.append(text)
                    }

                    firstViewController.myTableView.reloadData()
                    // store todos
                    UserDefaults.standard.set(firstViewController.toDos, forKey: "todos")
                }
            }
        }

        infoFromViewTwo = nil
        myInputText.text = ""
        myButton.setTitle("Back", for: .normal)
        tabBarController?.selectedIndex = 0
    }

    override func viewWillAppear(_: Bool) {
        if infoFromViewTwo != nil {
            if let firstViewController = tabBarController?.viewControllers?[0] as? FirstViewController {
                myInputText.text = firstViewController.toDos[infoFromViewTwo!]
            }
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        myInputText.delegate = self
        myInputText.becomeFirstResponder()
    }
}
