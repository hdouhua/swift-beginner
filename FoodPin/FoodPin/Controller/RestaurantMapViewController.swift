//
//  MapViewController.swift
//  FoodPin
//
//  Created by Yilin on 2019/8/14.
//  Copyright © 2019 Yilin. All rights reserved.
//

import MapKit
import UIKit

class RestaurantMapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!

    var restaurant: Restaurant?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        if let location = restaurant?.location {
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(location, completionHandler: { placemarks, error in
                if let error = error {
                    print(error)
                    return
                }

                if let placemarks = placemarks {
                    // 取得第一個地面目標
                    let placemark = placemarks[0]

                    // 加上標註
                    let annotation = MKPointAnnotation()
                    annotation.title = self.restaurant?.name
                    annotation.subtitle = self.restaurant?.type

                    if let location = placemark.location {
                        annotation.coordinate = location.coordinate

                        // 顯示標註
                        self.mapView.showAnnotations([annotation], animated: true)
                        self.mapView.selectAnnotation(annotation, animated: true)
                    }
                }

            })
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
