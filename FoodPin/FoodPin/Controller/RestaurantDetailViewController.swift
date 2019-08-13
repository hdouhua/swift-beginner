//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by User on 13/8/19.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: RestaurantDetailHeaderView!

    var restaurant: Restaurant?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        navigationItem.largeTitleDisplayMode = .never

        if restaurant != nil {
            headerView.headerImageView.image = UIImage(named: restaurant!.image)
            headerView.nameLabel.text = restaurant!.name
            headerView.typeLabel.text = restaurant!.type
            headerView.heartImageView.isHidden = !restaurant!.isVisited
        }

        // Set the table view's delegate and data source
        tableView.delegate = self
        tableView.dataSource = self

        // Configure the table view's style
        tableView.separatorStyle = .none

        // Customize the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
//        navigationController?.hidesBarsOnSwipe = false

        tableView.contentInsetAdjustmentBehavior = .never
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - detail tableview

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            // phone
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailIconTextCell", for: indexPath) as! RestaurantDetailIconTextCell
            cell.iconImageView.image = UIImage(named: "phone")
            cell.shortTextLabel.text = restaurant?.phone
            cell.selectionStyle = .none

            return cell

        case 1:
            // location
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailIconTextCell", for: indexPath) as! RestaurantDetailIconTextCell
            cell.iconImageView.image = UIImage(named: "map")
            cell.shortTextLabel.text = restaurant?.location
            cell.selectionStyle = .none

            return cell
        case 2:
            // description
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailTextCell", for: indexPath) as! RestaurantDetailTextCell
            cell.descriptionLabel.text = restaurant?.description
            cell.selectionStyle = .none

            return cell
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
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
