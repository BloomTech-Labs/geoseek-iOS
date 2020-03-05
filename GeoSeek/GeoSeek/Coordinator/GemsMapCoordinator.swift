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
//    var userLocationLat: CLLocationDegrees?
//    var userLocationLong: CLLocationDegrees?
//    var setLocation: CLLocation?
    


    var delegate: GemsMapCoordinatorDelegate?
    
    init(window: UIWindow) {
        self.window = window
        super.init()
        
        let tempLocation = CLLocationCoordinate2D(latitude: 33.812794, longitude: -117.9190981)
        self.userLocationLat = tempLocation.latitude
        self.userLocationLong = tempLocation.longitude
    
    }
    
    override func start() {
        print("MainCoordinator.toVCOne: change views")
        
        let viewController = GemsMapVC.instantiate()
//        navigationController = UINavigationController()
        viewController.coordinator = self
        viewController.delegate = delegate
//        window.rootViewController = navigationController
        navigationController?.isNavigationBarHidden = true
        
        
        if let vc = navigationController?.viewControllers.first {
            print(vc.description)
        } else {
            let vc = GemsMapVC.instantiate()
            vc.coordinator = self
            vc.delegate = delegate
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func navigateToCreateGemCoordinator() {
//        print("GemsMapCoordinator")
//        delegate?.goToCreateGemController()
    }
}
