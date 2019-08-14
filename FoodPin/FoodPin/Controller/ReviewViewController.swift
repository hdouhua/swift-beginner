//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by User on 14/8/19.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var rateButtons: [UIButton]!
    @IBOutlet var closeButton: UIButton!

    var restaurant: Restaurant?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        if let imageData = restaurant?.image {
            backgroundImageView.image = UIImage(data: imageData)
        }

        // blur effect
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)

        // animation
        let movingRightTranform = CGAffineTransform(translationX: 600, y: 0)
        let scaleUpTransform = CGAffineTransform(scaleX: 5.0, y: 5.0)
        let combineTransform = scaleUpTransform.concatenating(movingRightTranform)

        // rating buttons
        for rateButton in rateButtons {
//            rateButton.transform = movingRightTranform
            rateButton.transform = combineTransform
            // hidden
            rateButton.alpha = 0
        }

        // close button
        closeButton.transform = movingRightTranform
    }

    override func viewWillAppear(_: Bool) {
//        // animation with delay
//        let delayDelta = 0.05
//        for idx in 0...4 {
//            UIView.animate(withDuration: 0.4, delay: 0.1 + delayDelta * Double(idx), options: [], animations: {
//                self.rateButtons[idx].transform = .identity
//                self.rateButtons[idx].alpha = 1.0
//            }, completion: nil)
//        }

//        // animation with damping
//        for rateButton in rateButtons {
//            UIView.animate(withDuration: 0.8, delay: 0.1, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.3, options: [], animations: {
//                rateButton.transform = .identity
//                rateButton.alpha = 1.0
//            }, completion: nil)
//        }

        UIView.animate(withDuration: 1.0) {
            for rateButton in self.rateButtons {
                rateButton.transform = .identity
                rateButton.alpha = 1.0
            }

            self.closeButton.transform = .identity
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
