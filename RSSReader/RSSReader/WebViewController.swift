//
//  WebViewController.swift
//  RSSReader
//
//  Created by Yilin on 2019/7/29.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var linkFromOne: String?

    @IBOutlet var myIndicator: UIActivityIndicatorView!
    @IBOutlet var myWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.navigationDelegate = self
        myIndicator.hidesWhenStopped = true

        if let okLink = linkFromOne, let okURL = URL(string: okLink) {
            let request = URLRequest(url: okURL)
            myWebView.load(request)
        }
    }

    func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
        myIndicator.startAnimating()
    }

    func webView(_: WKWebView, didFinish _: WKNavigation!) {
        myIndicator.stopAnimating()
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
