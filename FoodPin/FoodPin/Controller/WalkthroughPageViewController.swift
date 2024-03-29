//
//  WalkthroughController.swift
//  FoodPin
//
//  Created by Yilin on 2019/8/17.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

protocol WalkthroughPageViewControllerDelegate: AnyObject {
    func didUpdatePageIndex(currentIndex: Int)
}

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var pageHeadings = ["CREATE YOUR OWN FOOD GUIDE", "SHOW YOU THE LOCATION", "DISCOVER GREAT RESTAURANTS"]
    var pageImages = ["onboarding-1", "onboarding-2", "onboarding-3"]
    var pageSubHeadings = ["Pin your favorite restaurants and create your own food guide",
                           "Search and locate your favourite restaurant on Maps",
                           "Find restaurants shared by your friends and other foodies"]

    var currentIndex = 0

    weak var walkthroughDelegate: WalkthroughPageViewControllerDelegate?

    // MARK: - UIPageViewControllerDataSource

    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1

        return contentViewController(at: index)
    }

    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1

        return contentViewController(at: index)
    }

//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating _: Bool, previousViewControllers _: [UIViewController], transitionCompleted completed: Bool) {
//        if completed {
//            if let contentViewController = pageViewController.viewControllers?.first as? WalkthroughContentViewController {
//                currentIndex = contentViewController.index
//
//                walkthroughDelegate?.didUpdatePageIndex(currentIndex: contentViewController.index)
//            }
//        }
//    }

    func contentViewController(at index: Int) -> WalkthroughContentViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }

        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.index = index

            return pageContentViewController
        }

        return nil
    }

    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        dataSource = self

        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }

        delegate = self
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
