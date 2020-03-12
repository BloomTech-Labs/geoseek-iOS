//
//  LandingPageVC.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 3/4/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import CoreLocation

protocol UserLocationDelegate {
    var userLocation: CLLocationCoordinate2D? { get set }
}

class LandingPageVC: UIViewController, CLLocationManagerDelegate, Storyboarded {
    
    var locationManager: CLLocationManager?
    var coordinator: MainCoordinator?
    var userLocation: CLLocation?
    
    var delegate: UserLocationDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager?.delegate = self
    }
    


    @IBAction func setLocationTapped(_ sender: Any) {
        locationManager?.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        userLocation = locationManager?.location
        delegate?.userLocation = userLocation?.coordinate
        coordinator?.toGemsMapViewController()
    }
}
