//
//  MainCoordinator.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 2/25/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import Mapbox
import CoreLocation

class MainCoordinator: BaseCoordinator {
    
    var window: UIWindow
    var navigationController = UINavigationController()
    var childCoordinators = [BaseCoordinator]()
    let locationManager = CLLocationManager()
    let gemController = GemController()
    var gemsMapVC = GemsMapVC()
    
    let gemsMapCoordinator: GemsMapCoordinator
    var navControllers: [UINavigationController] = []
    var currentUserLocation: CLLocationCoordinate2D?
    var delegate: UserLocationDelegate?
    var addGemCoordinates: CLLocation?
    
    init(window: UIWindow) {
        self.window = window
        self.gemsMapCoordinator = GemsMapCoordinator(window: self.window)
    }
    
    override func start() {
        window.makeKeyAndVisible()
        window.rootViewController = self.navigationController
        
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentUserLocation = locationManager.location?.coordinate
            toGemsMapViewController()
        } else {
            toLandingPageVC()
        }
    }
    
    func locationsManager(_ status: CLAuthorizationStatus) {
        
        delegate?.userLocation = userLocation

        toGemsMapViewController()
//        if Int(status.rawValue) == 3 || Int(status.rawValue) == 4 {
//            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
//                if CLLocationManager.isRangingAvailable() {
//
//                }
//            }
//        }
//        print(
//            "Location BB: Lat \(String(describing: userLocation?.coordinate.latitude)) and Long \(String(describing: userLocation?.coordinate.longitude))")
        
    }

    
    func toGemsMapViewController() {
        gemsMapCoordinator.navigationController = navigationController
        gemsMapCoordinator.delegate = self
        gemsMapCoordinator.userLocation = userLocation
        gemsMapCoordinator.gemController = gemController
        gemsMapCoordinator.start()
    }
    
    func toLandingPageVC() {
        let vc = LandingPageVC.instantiate()
        vc.locationManager = locationManager
        vc.coordinator = self
        vc.delegate = self
        navigationController.pushViewController(vc, animated: true)
    }
}

extension MainCoordinator: GemsMapCoordinatorDelegate {
    func goToCreateGemController() {
        let createGemCoordinator = CreateGemCoordinator()
        createGemCoordinator.gemController = gemController
        createGemCoordinator.navigationController = navigationController
        createGemCoordinator.delegate = self
        createGemCoordinator.locationManager = locationManager
        createGemCoordinator.start()
        createGemCoordinator.userLocation = currentUserLocation
    }
}

extension MainCoordinator: CreateGemCoordinatorDelegate {
    
    func presentChooseLocationVC() {
    }
    
    func presentGemsMap() {
        gemsMapCoordinator.start()
        navigationController.topViewController?.dismiss(animated: true)
    }
}

extension MainCoordinator: UserLocationDelegate {
    var userLocation: CLLocationCoordinate2D? {
        get {
            currentUserLocation
        }
        set {
            currentUserLocation = newValue
        }
    }
}
