//
//  GemDetailVCCoordinator.swift
//  GeoSeek
//
//  Created by Jerry haaser on 3/18/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import CoreLocation

protocol GemDetailVCCoordinatorDelegate: class {
    
}

class GemDetailVCCoordinator: BaseCoordinator {
    
    var gemController: GemController?
    var navigationController: UINavigationController?
    var locationManager: CLLocationManager?
    
    var delegate: GemDetailVCCoordinatorDelegate?
    
    override func start() {
        let viewController = GemDetailVC.instantiate()
        viewController.coordinator = self
        viewController.delegate = delegate
        viewController.locationManager = locationManager
        viewController.gemController = gemController
        
        navigationController?.setViewControllers([viewController], animated: true)
    }
    
    
}
