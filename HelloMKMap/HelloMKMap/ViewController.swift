//
//  ViewController.swift
//  HelloMKMap
//
//  Created by Yilin on 2019/7/28.
//  Copyright © 2019 Yilin. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var map: MKMapView!
    var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         let latitude: CLLocationDegrees = 1.2847052
         let longtitude: CLLocationDegrees = 103.8377355
         let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
         let xScale: CLLocationDegrees = 0.01
         let yScale: CLLocationDegrees = 0.01
         let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: yScale, longitudeDelta: xScale)
         let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)

         map.setRegion(region, animated: true)
         //        map.mapType = .satellite
         */

        /*
         let annotation = MKPointAnnotation()
         annotation.coordinate = location
         annotation.title = "Pearl Park"
         annotation.subtitle = "I was there ...."

         map.addAnnotation(annotation)
         */

        /*
         // get user location
         locationManager = CLLocationManager()
         locationManager?.requestWhenInUseAuthorization()
         if let coordination = locationManager?.location?.coordinate {
             let xScale:CLLocationDegrees = 0.005
             let yScale:CLLocationDegrees = 0.005
             let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: yScale, longitudeDelta: xScale)
             let region = MKCoordinateRegion(center: coordination,span: span)
             map.setRegion(region, animated: true)
         }
         */

        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.activityType = .automotiveNavigation
        locationManager?.startUpdatingLocation()

        if let coordination = locationManager?.location?.coordinate {
            let xScale: CLLocationDegrees = 0.005
            let yScale: CLLocationDegrees = 0.005
            let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: yScale, longitudeDelta: xScale)
            let region = MKCoordinateRegion(center: coordination, span: span)
            map.setRegion(region, animated: true)
        }
        map.userTrackingMode = .followWithHeading
    }

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("-------------------")
        print(locations[0].coordinate.latitude)
        print(locations[0].coordinate.longitude)
    }
}
