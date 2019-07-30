//
//  ViewController.swift
//  HelloTableView
//
//  Created by Yilin on 2019/7/28.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let fruitArray = ["apple", "banana", "watermelon", "mango"]
    let colorArray = ["green", "yellow", "red"]

    func numberOfSections(in _: UITableView) -> Int {
        return 2
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return fruitArray.count
        } else {
            return colorArray.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//       TableView information
//        indexPath.section
//        indexPath.row

//        1) new cell
//        var cell = UITableViewCell()

//        2) reuse cell prototype
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = fruitArray[indexPath.row]

        if indexPath.section == 0 {
            cell.textLabel?.text = fruitArray[indexPath.row]
        } else {
            cell.textLabel?.text = colorArray[indexPath.row]
        }

        return cell
    }

    func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Fruit"
        } else {
            return "Color"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
