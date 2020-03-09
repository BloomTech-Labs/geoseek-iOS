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
    var navControllers: [UINavigationController] = []
    let gemsMapCoordinator: GemsMapCoordinator
    var addGemCoordinates: CLLocation?
    weak var coordinator: BaseCoordinator?
    var currentUserLocation: CLLocationCoordinate2D?
    
    
    init(window: UIWindow) {
        self.window = window
        self.gemsMapCoordinator = GemsMapCoordinator(window: self.window)
    }
    
    override func start() {
        window.makeKeyAndVisible()
        window.rootViewController = self.navigationController
        toLandingPageVC()
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
        print("Brandi made a LandingPageVC")
    }
}

extension MainCoordinator: GemsMapCoordinatorDelegate {
    func goToCreateGemController() {
        let createGemCoordinator = CreateGemCoordinator()
        createGemCoordinator.gemController = gemController
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
