//
//  NewViewController.swift
//  HelloTabBarAgain
//
//  Created by Yilin on 2019/7/28.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {
    var messageFromViewOne: String?

    @IBOutlet var myTextInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        myTextInput.text = messageFromViewOne
    }

    override func viewWillDisappear(_: Bool) {
        myTextInput.becomeFirstResponder()
    }

    @IBAction func ok(_: UIButton) {
        if let inputText = myTextInput.text {
            myTextInput.text = ""
            myTextInput.resignFirstResponder()

            if let firstViewController = self.tabBarController?.viewControllers?[0] as? ViewController {
                firstViewController.myLabel.text = inputText
                tabBarController?.selectedIndex = 0
            }
        }
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
