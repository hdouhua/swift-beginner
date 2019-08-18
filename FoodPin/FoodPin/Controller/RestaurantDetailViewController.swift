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

    func displayDetail() {
        if restaurant != nil {
            if let imageData = restaurant!.image {
                headerView.headerImageView.image = UIImage(data: imageData)
            }
            headerView.nameLabel.text = restaurant!.name
            headerView.typeLabel.text = restaurant!.type
            headerView.heartImageView.isHidden = !restaurant!.isVisited
            if restaurant!.rating != nil, restaurant!.rating != "" {
                headerView.ratingImageView.image = UIImage(named: restaurant!.rating!)
            }
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        navigationItem.largeTitleDisplayMode = .never

        displayDetail()

        // Set the table view's delegate and data source
        tableView.delegate = self
        tableView.dataSource = self

        // Configure the table view's style
        tableView.separatorStyle = .none

        // Customize the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white

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
        return 5
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
            cell.descriptionLabel.text = restaurant?.summary
            cell.selectionStyle = .none

            return cell

        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailMapTitleCell", for: indexPath) as! RestaurantDetailSeparatorCell
            cell.titleLabel.text = NSLocalizedString("HOW TO GET HERE", comment: "HOW TO GET HERE")
            cell.selectionStyle = .none

            return cell

        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailMapCell", for: indexPath) as! RestaurantDetailMapCell
            if let location = restaurant?.location {
                cell.configure(location: location)
            }
            cell.selectionStyle = .none

            return cell

        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        if segue.identifier == "showMap" {
            if let dvc = segue.destination as? RestaurantMapViewController {
                dvc.restaurant = restaurant
            }
        } else if segue.identifier == "showReview" {
            if let dvc = segue.destination as? ReviewViewController {
                dvc.restaurant = restaurant
            }
        }
    }

    @IBAction func rateRestaurant(segue: UIStoryboardSegue) {
        dismiss(animated: true) {
            if let rating = segue.identifier {
                self.restaurant?.rating = rating
                self.headerView.ratingImageView.image = UIImage(named: rating)

                if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                    appDelegate.saveContext()
                }

                // addtional animation
                let scaleTransform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.headerView.ratingImageView.transform = scaleTransform
                self.headerView.ratingImageView.alpha = 0

                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.7, options: [], animations: {
                    self.headerView.ratingImageView.transform = .identity
                    self.headerView.ratingImageView.alpha = 1.0
                })
            }
        }
    }

    @IBAction func close(segue _: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
}
