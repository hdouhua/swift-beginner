//
//  ViewController.swift
//  HelloDownloadImage
//
//  Created by User on 29/7/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var myImageView: UIImageView!

    var session: URLSession?

    override func viewDidLoad() {
        super.viewDidLoad()

        // main queue do this, which make UI hanging
        let imageUrl = "https://developer.apple.com/assets/elements/icons/swift/swift-64x64_2x.png"
        if let url = URL(string: imageUrl) {
            // 1)
//            do {
//                let downloadedImage = UIImage(data: try Data(contentsOf: url))
//                myImageView.image = downloadedImage
//            } catch {
//                print("Error: \(error.localizedDescription)")
//            }

            // 2)
//            DispatchQueue.global().async {
//                do {
//                    let downloadedImage = UIImage(data: try Data(contentsOf: url))
//                    DispatchQueue.main.async {
//                        self.myImageView.image = downloadedImage
//                    }
//                } catch {
//                    print("Error: \(error.localizedDescription)")
//                }
//            }

            // 3) via URLSession
            session = URLSession(configuration: .default)

            /*
             let task1 =  session?.dataTask(with: url, completionHandler: { (data, response, error) in
                 if error != nil {
                     print("download error: \(error!.localizedDescription)")
                     return
                 }else if let downloadedData = data {
                     let downloadedImage = UIImage(data: downloadedData)
                     DispatchQueue.main.async {
                         self.myImageView.image = downloadedImage
                     }
                 }
             })
             task1?.resume()
             */

            let task2 = session?.downloadTask(with: url, completionHandler: { imageUrl, _, error in
                if error != nil {
                    print("download error: \(error!.localizedDescription)")
                    return
                } else {
                    if let loadedUrl = imageUrl {
                        do {
                            let downloadedImage = UIImage(data: try Data(contentsOf: loadedUrl))
                            DispatchQueue.main.async {
                                self.myImageView.image = downloadedImage
                            }
                        } catch {}
                    }
                }
            })
            task2?.resume()
        }
    }
}
