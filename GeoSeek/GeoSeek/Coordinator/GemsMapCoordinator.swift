//
//  GemMapCoordinator.swift
//  GeoSeek
//
//  Created by morse on 3/4/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

// protocol

import UIKit
import Mapbox
import CoreLocation

protocol GemsMapCoordinatorDelegate: class {
    func goToCreateGemController()
    func showMenuVC()
    func showGemDetails(for annotation: MGLAnnotation)
}

class GemsMapCoordinator: BaseCoordinator {
    
    var gemController: GemController?
    var navigationController: UINavigationController?
    var locationManager: CLLocationManager?
    
    var delegate: GemsMapCoordinatorDelegate?
    
    override func start() {
        let viewController = GemsMapVC.instantiate()
        viewController.coordinator = self
        viewController.delegate = delegate
        viewController.locationManager = locationManager
        viewController.gemController = gemController
        navigationController?.setViewControllers([viewController], animated: true)
    }
}
