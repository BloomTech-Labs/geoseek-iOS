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
        toLandingPageVC()
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
