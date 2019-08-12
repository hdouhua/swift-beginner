//
//  ViewController.swift
//  RandomUser
//
//  Created by User on 29/7/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

struct User {
    var name: String?
    var email: String?
    var number: String?
    var image: String?
}

// https://roadfiresoftware.com/2018/02/how-to-parse-json-with-swift-4/
struct Result: Codable {
    var results: [RandomUser]?
    struct UserName: Codable {
        var title: String
        var first: String
        var last: String

        func getFullName() -> String {
            return title + first + last
        }
    }

    struct Picture: Codable {
        var large: String
    }

    struct RandomUser: Codable {
        var name: UserName
        var email: String
        var cell: String
        var picture: Picture
    }
}

class ViewController: UIViewController {
    @IBOutlet var userImage: UIImageView! {
        didSet {
            userImage.layer.cornerRadius = 128.0 / 2
            userImage.clipsToBounds = true
            print("userImage updated \(userImage.frame.width) \(userImage.bounds.width)")
        }
    }

    @IBOutlet var userLabel: UILabel!

    var infoTableViewController: InfoTableViewController?

    let session = URLSession(configuration: .default)

    override func viewDidLoad() {
        super.viewDidLoad()

        // change navigation bar color
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.67, green: 0.2, blue: 0.157, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        refresh(UIBarButtonItem())
    }

    @IBAction func refresh(_: UIBarButtonItem) {
//        let aUser = User(name: "abc", email: "abc@live.com", number: "12345678", image: "https://developer.apple.com/assets/elements/icons/swift/swift-64x64_2x.png")
//        setInfo(info: aUser)

        downloadInfo(apiUrl: "https://randomuser.me/api/")
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "more" {
            infoTableViewController = segue.destination as? InfoTableViewController
        }
    }

//    override func viewDidAppear(_: Bool) {
//        // make user image circle
//        userImage.layer.cornerRadius = userImage.frame.width / 2
//        userImage.clipsToBounds = true
//    }

    func popAlert(title: String) {
        let alert = UIAlertController(title: title, message: "please try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func downloadInfo(apiUrl: String) {
        if let url = URL(string: apiUrl) {
            (session.dataTask(with: url) { data, _, error in
                if error != nil {
                    let errorCode = (error! as NSError).code
                    if errorCode == -1009 {
                        DispatchQueue.main.async {
                            self.popAlert(title: "no internet connection")
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.popAlert(title: "something with wrong")
                        }
                    }
                    return
                }

                if let loadedData = data {
                    do {
//                        let json = try JSONSerialization.jsonObject(with: loadedData, options: [])

                        let jsonDecode = JSONDecoder()
                        let json = try jsonDecode.decode(Result.self, from: loadedData)

                        DispatchQueue.main.async {
//                            self.parseJson(json: json)
                            if let aUser = json.results?[0] {
                                self.setInfo(info: User(name: aUser.name.getFullName(), email: aUser.email, number: aUser.cell, image: aUser.picture.large))
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self.popAlert(title: "something with wrong in JSONSerialization")
                        }
                    }
                }
            }).resume()
        }
    }

    func setInfo(info: User) {
        print("show user info")

        userLabel.text = info.name
        infoTableViewController?.emailLabel.text = info.email ?? "NA."
        infoTableViewController?.phoneLabel.text = info.number ?? "NA."

        setImage(image: info.image)
    }

    func setImage(image: String?) {
        if let url = URL(string: image!) {
            (session.downloadTask(with: url) { imageUrl, _, error in
                if error != nil {
                    print("download error: \(error!.localizedDescription)")
                    return
                } else {
                    if let loadedUrl = imageUrl {
                        do {
                            let downloadedImage = UIImage(data: try Data(contentsOf: loadedUrl))
                            DispatchQueue.main.async {
                                self.userImage.image = downloadedImage
//                                self.userImage.layer.cornerRadius = self.userImage.frame.width / 2
//                                self.userImage.clipsToBounds = true
                            }
                        } catch {
                            print("download error: \(error.localizedDescription)")
                        }
                    }
                }
            }).resume()
        }
    }

    func parseJson(json: Any) {
        if let okJson = json as? [String: Any] {
            if let results = okJson["results"] as? [[String: Any]] {
                for item in results {
                    for (k, v) in item {
                        print("\(k): \(v)")
                    }
                }
            }
        }
    }
}
