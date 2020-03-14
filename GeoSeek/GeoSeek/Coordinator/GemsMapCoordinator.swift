//
//  GemMapCoordinator.swift
//  GeoSeek
//
//  Created by morse on 3/4/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

// protocol

import UIKit
import CoreLocation

protocol GemsMapCoordinatorDelegate: class {
    func goToCreateGemController()
}

class GemsMapCoordinator: BaseCoordinator {
    
    let window: UIWindow
    var gemController: GemController?
    var navigationController: UINavigationController?
    var locationManager: CLLocationManager?
    
    var delegate: GemsMapCoordinatorDelegate?
    
    init(window: UIWindow) {
        self.window = window
        super.init()
    }
    
    override func start() {
        let viewController = GemsMapVC.instantiate()
        viewController.coordinator = self
        viewController.delegate = delegate
        viewController.locationManager = locationManager
        viewController.gemController = gemController
        navigationController?.isNavigationBarHidden = true
        navigationController?.setViewControllers([viewController], animated: true)
    }
}
