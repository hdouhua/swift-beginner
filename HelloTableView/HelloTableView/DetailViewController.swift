//
//  DetailViewController.swift
//  HelloTableView
//
//  Created by Yilin on 2019/7/28.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var infoFromViewOne: String?

    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var myLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let okFileName = infoFromViewOne {
            myImageView.image = UIImage(named: okFileName)
        }

        myLabel.text = infoFromViewOne
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
