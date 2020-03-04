//
//  LandingPageVC.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 3/4/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import CoreLocation

class LandingPageVC: UIViewController, CLLocationManagerDelegate, Storyboarded {
    
    var locationManager: CLLocationManager?
    weak var coordinator: MainCoordinator?
    var userLocation: CLLocation?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager?.delegate = self

        
    }
    


    @IBAction func setLocationTapped(_ sender: Any) {
        
        locationManager?.requestAlwaysAuthorization()

    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    userLocation = locationManager?.location
                }
            }
        }
        print(
        "Location: Lat  \(userLocation?.coordinate.latitude) and Long  \(userLocation?.coordinate.longitude)")
    }

}
