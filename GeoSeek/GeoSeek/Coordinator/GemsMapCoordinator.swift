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
    var navigationController: UINavigationController?
    var userLocation: CLLocationCoordinate2D?
    var delegate: GemsMapCoordinatorDelegate?
    
    init(window: UIWindow) {
        self.window = window
        super.init()
    }
    
    override func start() {
        let viewController = GemsMapVC.instantiate()
        viewController.coordinator = self
        viewController.delegate = delegate
        viewController.userLocation = userLocation
        navigationController?.isNavigationBarHidden = true
        navigationController?.setViewControllers([viewController], animated: true)
        
//        if let vc = navigationController?.viewControllers.first {
//            print(vc.description)
//        } else {
//            let vc = GemsMapVC.instantiate()
//            vc.coordinator = self
//            vc.delegate = delegate
//            navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
    func navigateToCreateGemCoordinator() {
//        print("GemsMapCoordinator")
//        delegate?.goToCreateGemController()
    }
}
