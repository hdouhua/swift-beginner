//
//  ViewController.swift
//  RSSReader
//
//  Created by Yilin on 2019/7/29.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

struct NewsItem {
    var title: String?
    var link: String?
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var objects = [NewsItem]()
    var session = URLSession(configuration: .default)
    var rssUrl = "http://www.techweb.com.cn/rss/allnews.xml"

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return objects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = objects[indexPath.row].title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "showInfo" {
            if let dvc = segue.destination as? WebViewController {
                if let selectedIndex = myTableView.indexPathForSelectedRow?.row {
                    dvc.linkFromOne = objects[selectedIndex].link
                }
            }
        }
    }

    @IBOutlet var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.dataSource = self
        myTableView.delegate = self

//        objects = [
//            NewsItem(title: "first news", link: "https://www.apple.com"),
//            NewsItem(title: "second news", link: "https://www.baidu.com"),
//            NewsItem(title: "third news", link: "https://www.google.com"),
//        ]

        downloadXML(withAddress: rssUrl)
    }

    func downloadXML(withAddress xmlAddress: String) {
        if let url = URL(string: xmlAddress) {
            let task = session.dataTask(with: url) {
                data, _, error in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                if let okData = data {
                    let parser = XMLParser(data: okData)
                    let rssParserDelegate = RSSParserDelegate()
                    parser.delegate = rssParserDelegate
                    if parser.parse() == true {
                        self.objects = rssParserDelegate.getResults()
                        DispatchQueue.main.async {
                            self.myTableView.reloadData()
                        }
                    } else {
                        print("parse failed")
                    }
//                    print(NSString(data: okData, encoding: String.Encoding.utf8.rawValue) ?? "")
                }
            }

            task.resume()
        }
    }
}
