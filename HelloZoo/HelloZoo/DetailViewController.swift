//
//  DetailViewController.swift
//  HelloZoo
//
//  Created by Yilin on 2019/8/25.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var detailDescriptionLabel: UILabel!
    @IBOutlet var interpretationLabel: UILabel!
    @IBOutlet var imageView: UIImageView!

    var json: [String: AnyObject]?

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        detailDescriptionLabel.text = json?["F_Location"] as? String
        interpretationLabel.text = json?["F_Feature"] as? String

        let itemUrl = URL(string: json?["F_Pic01_URL"] as? String ?? "")
        let urlSession = URLSession(configuration: .default)

        if let url = itemUrl {
            urlSession.downloadTask(with: url) { imageUrl, _, error in
                if error != nil {
                    print(error!)
                    return
                }

                if let loadedUrl = imageUrl {
                    do {
                        let downloadedImage = UIImage(data: try Data(contentsOf: loadedUrl))
                        DispatchQueue.main.async {
                            self.imageView.image = downloadedImage
                        }
                    } catch {
                        print("download error: \(error.localizedDescription)")
                    }
                }

            }.resume()
        }

        configureView()
    }

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            configureView()
        }
    }
}
