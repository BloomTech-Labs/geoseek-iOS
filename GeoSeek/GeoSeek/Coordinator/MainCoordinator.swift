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
    var navControllers: [UINavigationController] = []
    var gemController = GemController()
    let gemsMapCoordinator: GemsMapCoordinator
    var addGemCoordinates: CLLocation? {
        didSet {
            print("hi")
        }
    }
    var addGemLat: Double?
    var addGemLong: Double?
    
    let locationManager = CLLocationManager()
    weak var coordinator: BaseCoordinator?
    //    var userLocation: CLLocation?
    var currentUserLocation: CLLocationCoordinate2D?
    
    //NOTE: These may be wrong
    //var userLocation: CLLocation?
    var delegate: UserLocationDelegate?
    var gemsMapVC = GemsMapVC()
    
    init(window: UIWindow) {
        let navController1 = UINavigationController()
        let navController2 = UINavigationController()
        let navController3 = UINavigationController()
        let navController4 = UINavigationController()
        //        let navControllerMap = UINavigationController()
        
        navControllers = [navController1, navController2, navController3, navController4/*, navControllerMap*/]
        
        self.window = window
        self.gemsMapCoordinator = GemsMapCoordinator(window: self.window)
    }
    
    override func start() {
        window.makeKeyAndVisible()
        
        window.rootViewController = self.navigationController
        //        toGemsMapViewController()
        //toLandingPageVC()
        //checkStatus()
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentUserLocation = locationManager.location?.coordinate
            toGemsMapViewController()
        } else {
            toLandingPageVC()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func checkStatus() {
//        let status = CLLocationManager.authorizationStatus()
//        if status == CLAuthorizationStatus.authorizedAlways {
//            //userLocation = delegate?.userLocation
//            locationsManager(status)
//        } else if  status == CLAuthorizationStatus.authorizedWhenInUse {
//            //delegate?.userLocation = userLocation
//            locationsManager(status)
//        } else if status == CLAuthorizationStatus.notDetermined {
//
//            locationsManager(status)
//            toLandingPageVC()
//        }
//    }
    
    func locationsManager(_ status: CLAuthorizationStatus) {
        print(status.rawValue)
        //userLocation = locationManager.location
        delegate?.userLocation = userLocation
        //                    coordinator?.userLocationLat = userLocation?.coordinate.latitude
        //                    coordinator?.userLocationLong = userLocation?.coordinate.longitude
        toGemsMapViewController()
        if Int(status.rawValue) == 3 || Int(status.rawValue) == 4 {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    
                }
            }
        }
//        print(
//            "Location BB: Lat \(String(describing: userLocation?.coordinate.latitude)) and Long \(String(describing: userLocation?.coordinate.longitude))")
        
    }

    
    func toGemsMapViewController() {
        
        // TODO add this coordinator to the array of child coordinators?
        //        childCoordinators.append(gemsMapCoordinator)
//        navigationController.setViewControllers([], animated: true)
        gemsMapCoordinator.navigationController = navigationController
        gemsMapCoordinator.delegate = self
        gemsMapCoordinator.userLocation = userLocation
        gemsMapCoordinator.start()
    }
    
    func presentGSMapViewControllerOnMainThread() {
        
    }
    
    func toLandingPageVC() {
        let vc = LandingPageVC.instantiate()
        vc.locationManager = locationManager
        vc.coordinator = self
        vc.delegate = self
        navigationController.pushViewController(vc, animated: true)
        print("Brandi made a LandingPageVC")
        //        if let vc = navigationController.viewControllers.first {
        //            print(vc.description)
        //        } else {
        //            let vc = LandingPageVC.instantiate()
        //            vc.locationManager = locationManager
        //            vc.coordinator = self
        //            vc.delegate = self
        //            navigationController.pushViewController(vc, animated: true)
        //            print("Brandi made a LandingPageVC")
        //        }
//        vc.userLocation = CLLocation(latitude: 33.812794, longitude: -117.9190981)
    }
}

extension MainCoordinator: GemsMapCoordinatorDelegate {
    func goToCreateGemController() {
        let createGemCoordinator = CreateGemCoordinator() //CreateGemCoordinator(window: window)
        createGemCoordinator.navigationController = navigationController
        createGemCoordinator.delegate = self
        createGemCoordinator.start()
    }
}

extension MainCoordinator: CreateGemCoordinatorDelegate {
    
    func presentChooseLocationVC() {
        //        let chooseLocationCoordinator = ChooseLocationCoordinator(window: window)
        //        chooseLocationCoordinator.start()
    }
    
    func presentGemsMap() {
        print("Delegate here")
        //        toGemsMapViewController()
        //        gemsMapCoordinator.start()
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
