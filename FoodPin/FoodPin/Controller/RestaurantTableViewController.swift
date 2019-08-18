//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Yilin on 2019/8/11.
//  Copyright © 2019 Yilin. All rights reserved.
//

import CoreData
import UIKit

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    @IBOutlet var emptyRestaurantView: UIView!
    @IBOutlet var importBarButton: UIBarButtonItem!

    var searchController: UISearchController!

    var restaurants: [Restaurant] = []
    var searchResults: [Restaurant] = []

    // MARK: - Search

    func filterContent(for searchText: String) {
        searchResults = restaurants.filter { (restaurant) -> Bool in
            if let name = restaurant.name {
                return name.localizedStandardContains(searchText)
            }
            return false
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }

    // MARK: - NSFetchedResultsControllerDelegate

    var fetchResultController: NSFetchedResultsController<Restaurant>!

    func fetchRestaurants() {
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self

            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    restaurants = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
    }

    func controllerWillChangeContent(_: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange _: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }

        if let fetchedObjects = controller.fetchedObjects {
            restaurants = fetchedObjects as! [Restaurant]
        }
    }

    func controllerDidChangeContent(_: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    // MARK: - ViewController func

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        fetchRestaurants()

        importBarButton.isEnabled = !(restaurants.count > 0)

        tableView.backgroundView = emptyRestaurantView

        tableView.cellLayoutMarginsFollowReadableWidth = true
        navigationController?.navigationBar.prefersLargeTitles = true

        // Customize the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Rubik-Medium", size: 35.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor(red: 231, green: 76, blue: 60),
                NSAttributedString.Key.font: customFont,
            ]
        }

        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .white
//        navigationItem.searchController = searchController
        tableView.tableHeaderView = searchController.searchBar
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.hidesBarsOnSwipe = true
    }

    override func viewDidAppear(_: Bool) {
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            return
        }

        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
            present(walkthroughViewController, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if restaurants.count > 0 {
            tableView.backgroundView?.isHidden = true
            tableView.separatorStyle = .singleLine
        } else {
            tableView.backgroundView?.isHidden = false
            tableView.separatorStyle = .none
        }

        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive {
            return searchResults.count
        } else {
            return restaurants.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RestaurantTableViewCell {
            let restaurant = searchController.isActive ? searchResults[indexPath.row] : restaurants[indexPath.row]

            cell.nameLabel.text = restaurant.name
            if let imageData = restaurant.image {
                cell.thumbnailImageView.image = UIImage(data: imageData)
            }
            cell.typeLabel.text = restaurant.type
            cell.locationLabel.text = restaurant.location
            cell.checkImageView.isHidden = !restaurant.isVisited

            return cell
        }

        return UITableViewCell(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    }

    override func tableView(_: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let items = searchController.isActive ? searchResults : restaurants
        let isChecked = items[indexPath.row].isVisited

        let checkInAction = UIContextualAction(style: .normal, title: isChecked ? "Undo" : "Check") { _, _, completionHandler in

            if let cell = self.tableView.cellForRow(at: indexPath) as? RestaurantTableViewCell {
                cell.checkImageView.isHidden = isChecked

                items[indexPath.row].isVisited = !isChecked
            }

            // 呼叫完成處理器來解除動作按鈕
            completionHandler(true)
        }

        checkInAction.backgroundColor = UIColor(red: 46, green: 204, blue: 113)
        checkInAction.image = UIImage(named: isChecked ? "undo" : "tick")

        let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkInAction])

        return swipeConfiguration
    }

    override func tableView(_: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let restaurantToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(restaurantToDelete)

                appDelegate.saveContext()
            } else {
                self.restaurants.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }

            completionHandler(true)
        }

        let shareAction = UIContextualAction(style: .normal, title: "Share") { _, _, completionHandler in
            let items = self.searchController.isActive ? self.searchResults : self.restaurants
            let defaultText = "Just checking in at " + items[indexPath.row].name!

            let activityController: UIActivityViewController

            if let imageData = items[indexPath.row].image {
                let imageToShare = UIImage(data: imageData)
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare!], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }

            self.present(activityController, animated: true, completion: nil)

            completionHandler(true)
        }

        deleteAction.backgroundColor = UIColor(red: 231, green: 76, blue: 60)
        deleteAction.image = UIImage(named: "delete")

        shareAction.backgroundColor = UIColor(red: 254, green: 149, blue: 38)
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let dvc = segue.destination as? RestaurantDetailViewController {
                    dvc.restaurant = searchController.isActive ? searchResults[indexPath.row] : restaurants[indexPath.row]
                }
            }
        }
    }

    @IBAction func unwindToHome(_: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func importAction(_: UIBarButtonItem) {
        importData()
    }
}
