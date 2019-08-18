//
//  RateUsViewController.swift
//  FoodPin
//
//  Created by Yilin on 2019/8/18.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit
import WebKit

class RateUsViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    var targetUrl = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        navigationItem.largeTitleDisplayMode = .never

        if let url = URL(string: targetUrl) {
            let request = URLRequest(url: url)
            webView.load(request)
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
