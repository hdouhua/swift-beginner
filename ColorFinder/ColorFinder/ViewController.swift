//
//  ViewController.swift
//  ColorFinder
//
//  Created by User on 26/7/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var redValue = 255
    var greenValue = 255
    var blueValue = 255

    @IBOutlet var redText: UILabel!
    @IBOutlet var greenText: UILabel!
    @IBOutlet var blueText: UILabel!

    @IBAction func redSliderChange(_ sender: UISlider) {
        redValue = Int(sender.value)
        redText.text = "R: \(redValue)"
        changeBackgroundColor()
    }

    @IBAction func greenSliderChange(_ sender: UISlider) {
        greenValue = Int(sender.value)
        greenText.text = "G: \(greenValue)"
        changeBackgroundColor()
    }

    @IBAction func blueSliderChange(_ sender: UISlider) {
        blueValue = Int(sender.value)
        blueText.text = "B: \(blueValue)"
        changeBackgroundColor()
    }

    func changeBackgroundColor() {
        view.backgroundColor = UIColor(red: CGFloat(redValue) / 255, green: CGFloat(greenValue) / 255, blue: CGFloat(blueValue) / 255, alpha: 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
