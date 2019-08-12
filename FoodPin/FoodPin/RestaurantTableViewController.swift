//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Yilin on 2019/8/11.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]

    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso", "upstate", "traif", "grahamavenuemeats", "wafflewolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpubkitchen"]

    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]

    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]

    var restaurantIsVisited = Array(repeating: false, count: 21)

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
        return restaurantNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RestaurantTableViewCell {
            cell.nameLabel.text = restaurantNames[indexPath.row]
            cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
            cell.typeLabel.text = restaurantTypes[indexPath.row]
            cell.locationLabel.text = restaurantLocations[indexPath.row]
            cell.checkImageView.isHidden = !restaurantIsVisited[indexPath.row]

            return cell
        }

        return UITableViewCell(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    }

    override func tableView(_: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let isChecked = restaurantIsVisited[indexPath.row]
        let checkAction = UIContextualAction(style: .normal, title: isChecked ? "Undo" : "Check") { _, _, completionHandler in

            if let cell = self.tableView.cellForRow(at: indexPath) as? RestaurantTableViewCell {
                cell.checkImageView.isHidden = isChecked
            }

            self.restaurantIsVisited[indexPath.row] = !isChecked

            // 呼叫完成處理器來解除動作按鈕
            completionHandler(true)
        }

        checkAction.backgroundColor = UIColor(red: 46 / 255.0, green: 204 / 255.0, blue: 113 / 255.0, alpha: 1.0)
        checkAction.image = UIImage(named: isChecked ? "undo" : "tick")

        let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkAction])

        return swipeConfiguration
    }

    override func tableView(_: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            // 從資料源刪除列
            self.restaurantNames.remove(at: indexPath.row)
            self.restaurantLocations.remove(at: indexPath.row)
            self.restaurantTypes.remove(at: indexPath.row)
            self.restaurantIsVisited.remove(at: indexPath.row)
            self.restaurantImages.remove(at: indexPath.row)

            self.tableView.deleteRows(at: [indexPath], with: .fade)

            // 呼叫完成處理器來解除動作按鈕
            completionHandler(true)
        }

        let shareAction = UIContextualAction(style: .normal, title: "Share") { _, _, completionHandler in
            let defaultText = "Just checking in at " + self.restaurantNames[indexPath.row]

            let activityController: UIActivityViewController

            if let imageToShare = UIImage(named: self.restaurantImages[indexPath.row]) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }

            self.present(activityController, animated: true, completion: nil)

            completionHandler(true)
        }

        deleteAction.backgroundColor = UIColor(red: 231.0 / 255.0, green: 76.0 / 255.0, blue: 60.0 / 255.0, alpha: 1.0)
        deleteAction.image = UIImage(named: "delete")

        shareAction.backgroundColor = UIColor(red: 254.0 / 255.0, green: 149.0 / 255.0, blue: 38.0 / 255.0, alpha: 1.0)
        shareAction.image = UIImage(named: "share")

        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])

        return swipeConfiguration
    }

    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
     }
     */

    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             // Delete the row from the data source

     //            restaurantNames.remove(at: indexPath.row)
     //            restaurantLocations.remove(at: indexPath.row)
     //            restaurantTypes.remove(at: indexPath.row)
     //            restaurantIsVisited.remove(at: indexPath.row)
     //            restaurantImages.remove(at: indexPath.row)

     //            print(restaurantNames.count)
     //            tableView.reloadData()

             tableView.deleteRows(at: [indexPath], with: .fade)

         } else if editingStyle == .insert {
             // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
     }
     */

    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
     }
     */

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
