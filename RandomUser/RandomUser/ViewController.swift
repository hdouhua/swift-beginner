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

struct Result {
    
}

class ViewController: UIViewController {
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userLabel: UILabel!

    let session = URLSession(configuration: .default)

    var infoTableViewController: InfoTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // change navigation bar color
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.67, green: 0.2, blue: 0.157, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        downloadInfo(apiUrl: "https://randomuser.me/api/")
        let aUser = User(name: "abc", email: "abc@live.com", number: "12345678", image: "https://developer.apple.com/assets/elements/icons/swift/swift-64x64_2x.png")
        
        setInfo(info: aUser)
        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "more" {
            self.infoTableViewController = segue.destination as? InfoTableViewController
        }
    }
    
    func popAlert(title: String){
        let alert = UIAlertController(title: title, message: "please try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func downloadInfo(apiUrl: String)  {
        if let url = URL(string: apiUrl) {
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    let errorCode =  (error! as NSError).code
                    if errorCode == -1009 {
                        DispatchQueue.main.async {
                            self.popAlert(title: "no internet connection")
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.popAlert(title: "something with wrong")
                        }
                    }
                    return
                }
                
                if let loadedData = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: loadedData, options:[])
                        DispatchQueue.main.async {
                            self.parseJson(json: json)
                        }
                    }catch{
                        DispatchQueue.main.async {
                            self.popAlert(title: "something with wrong in JSONSerialization")
                        }
                    }
                }
            }
            task.resume()
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
        let session = URLSession(configuration: .default)

        if let url = URL(string: image!) {
           let task =  session.downloadTask(with: url) { imageUrl, _, error in
                if error != nil {
                    print("download error: \(error!.localizedDescription)")
                    return
                } else {
                    if let loadedUrl = imageUrl {
                        do {
                            let downloadedImage = UIImage(data: try Data(contentsOf: loadedUrl))
                            DispatchQueue.main.async {
                                print("i am here now")
                                self.userImage.image = downloadedImage
                            }
                        } catch {
                             print("download error: \(error.localizedDescription)")
                        }
                    }
                }
            }
            
            task.resume()
        }
    }

    func parseJson(json: Any) {
        if let okJson = json as? [String:Any] {
            if let infoDict =  okJson["results"] as? [[String:Any]] {
                print("\(self.getUserFullName(nameDict: infoDict[0]["name"]))")
                print("\(infoDict[0]["email"] ?? "no email")")
//                for (k,v) in infoDict {
//                    print("\(k): \(v)")
//                }
            }
        }
    }
    
    func getUserFullName(nameDict: Any?)->String{
        if let okDict = nameDict as? [String: String] {
            let firstName =  okDict["first"] ?? ""
            let lastName = okDict["last"] ?? ""
            return firstName + "" + lastName
        }
        return "NA."
    }
    
    override func viewDidAppear(_: Bool) {
        // make user image circle
        userImage.layer.cornerRadius = userImage.frame.width / 2
        userImage.clipsToBounds = true
        
    }
}
