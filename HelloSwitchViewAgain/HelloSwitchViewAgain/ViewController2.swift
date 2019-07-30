//
//  ViewController2.swift
//  HelloSwitchViewAgain
//
//  Created by Yilin on 2019/7/28.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func goView3(_: UIButton) {
        if let vc3 = storyboard?.instantiateViewController(withIdentifier: "view3") as? ViewController3 {
            print(navigationController as Any)
//            present(vc3, animated: true, completion: nil)

            navigationController?.pushViewController(vc3, animated: true)
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
