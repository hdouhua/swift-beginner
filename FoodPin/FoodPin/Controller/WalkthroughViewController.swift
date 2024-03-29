//
//  WalkthroughViewController.swift
//  FoodPin
//
//  Created by Yilin on 2019/8/17.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController, WalkthroughPageViewControllerDelegate {
    var walkthroughPageViewController: WalkthroughPageViewController?

    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }

    @IBOutlet var skipButton: UIButton!

    @IBAction func skipButtonTap(sender _: UIButton) {
        UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
        dismiss(animated: true, completion: nil)
    }

    @IBAction func nextButtonTap(sender _: UIButton) {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0 ... 1:
                walkthroughPageViewController?.forwardPage()
            case 2:
                // UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
                dismiss(animated: true, completion: nil)
            default:
                break
            }
        }

        updateUI()
    }

    func updateUI() {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0 ... 1:
                nextButton.setTitle(NSLocalizedString("NEXT", comment: "NEXT"), for: .normal)
                skipButton.isHidden = false
            case 2:
                nextButton.setTitle(NSLocalizedString("GET STARTED", comment: "GET STARTED"), for: .normal)
                skipButton.isHidden = true
            default:
                break
            }

            pageControl.currentPage = index
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if let pageViewController = segue.destination as? WalkthroughPageViewController {
            walkthroughPageViewController = pageViewController
            walkthroughPageViewController?.walkthroughDelegate = self
        }
    }

    func didUpdatePageIndex(currentIndex _: Int) {
        updateUI()
    }
}
