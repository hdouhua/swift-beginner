//
//  AnimalTableViewController.swift
//  HelloTableView
//
//  Created by Yilin on 2019/7/28.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class AnimalTableViewController: UITableViewController {
    let animalArray = ["cat", "chicken", "dog", "elephant", "fox", "goat", "kangaroo", "monkey", "mouse", "penguin", "rabbit", "snail"]

//    override var prefersStatusBarHidden: Bool {
//        return true
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return animalArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SpecialTableViewCell {
            cell.specialLabel?.text = animalArray[indexPath.row]
            cell.specialImageView?.image = UIImage(named: animalArray[indexPath.row])
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = animalArray[indexPath.row]
            cell.imageView?.image = UIImage(named: animalArray[indexPath.row])
            return cell
        }
    }

    override func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "showDetail" {
            let dvc = segue.destination as? DetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            if let selectedRow = selectedIndexPath?.row {
                dvc?.infoFromViewOne = animalArray[selectedRow]
                dvc?.navigationItem.title = animalArray[selectedRow]
            }
        }
    }
}
