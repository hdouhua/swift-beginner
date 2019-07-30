//
//  FirstViewController.swift
//  ToDoList
//
//  Created by Yilin on 2019/7/28.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var toDos = UserDefaults.standard.stringArray(forKey: "todos") ?? [String]()

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return toDos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = toDos[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Marker Felt", size: 15.0)
        return cell
    }

    func tableView(_: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDos.remove(at: indexPath.row)
            UserDefaults.standard.set(toDos, forKey: "todos")
            myTableView.reloadData()
        }
    }

    func tableView(_: UITableView, shouldHighlightRowAt _: IndexPath) -> Bool {
        return false
    }

    func tableView(_: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if let secondViewController = tabBarController?.viewControllers?[1] as? SecondViewController {
            secondViewController.infoFromViewTwo = indexPath.row
            tabBarController?.selectedIndex = 1
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBOutlet var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.dataSource = self
        myTableView.delegate = self
    }
}
