//
//  MasterViewController.swift
//  HelloZoo
//
//  Created by Yilin on 2019/8/25.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    var detailViewController: DetailViewController?
    var dataArray = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//        https://data.taipei/#/dataset/detail?id=5cb73231-b741-48b3-bec3-2ef57bb10029
        let url = URL(string: "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=f18de02f-b6c9-47c0-8cda-50efad621c14&q=&limit=100&offset=0")

        let urlSession = URLSession(configuration: .default)
        urlSession.dataTask(with: url!, completionHandler: { data, _, error in
            if error != nil {
                print(error!)
            } else {
                if let loadedData = data {
                    do {
                        let dataDic = try JSONSerialization.jsonObject(with: loadedData, options: []) as? [String: [String: AnyObject]]

                        if let dic = dataDic {
                            let array = dic["result"]!["results"] as! [AnyObject]
                            self.dataArray = array.filter { obj in
                                let name = obj["F_Name_Latin"] as? String
                                let url = obj["F_Pic01_URL"] as? String
                                if name == nil || name == "" {
                                    return false
                                }

                                if url == nil || url == "" {
                                    return false
                                }
                                return true
                            }

                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }

                    } catch {
                        print("Error!")
                    }
                }

                if let split = self.splitViewController {
                    let controllers = split.viewControllers
                    self.detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
                }
            }
        }).resume()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController

                let item = dataArray[indexPath.row]
                let json = item as! [String: AnyObject]

                controller.json = json
                controller.navigationItem.title = json["F_Name_Ch"] as? String
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]["F_Name_Ch"] as? String

        return cell
    }
}
