//
//  RestaurantDetailMapCell.swift
//  FoodPin
//
//  Created by Yilin on 2019/8/13.
//  Copyright © 2019 Yilin. All rights reserved.
//

import MapKit
import UIKit

class RestaurantDetailMapCell: UITableViewCell {
    @IBOutlet var mapView: MKMapView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(location: String) {
        // 取得位置
        let geoCoder = CLGeocoder()

        geoCoder.geocodeAddressString(location, completionHandler: { placemarks, error in
            if let error = error {
                print(print("failed to get GeoCoder: \(error.localizedDescription)"))
                return
            }

            if let placemarks = placemarks {
                // 取得第一個地理座標
                let placemark = placemarks[0]

                // 加上標註
                let annotation = MKPointAnnotation()

                if let location = placemark.location {
                    // 顯示標註
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)

                    // 設定縮放程度
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }

        })
    }
}
