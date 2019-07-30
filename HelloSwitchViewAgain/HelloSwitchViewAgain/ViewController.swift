//
//  ViewController.swift
//  HelloSwitchViewAgain
//
//  Created by Yilin on 2019/7/28.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func goView2(_: UIButton) {
        let viewController2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "view2")

        // from bottom to top
        present(viewController2, animated: true, completion: nil)

        // from right to left
//        self.navigationController?.pushViewController(viewController2, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
