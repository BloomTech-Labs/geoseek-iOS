//
//  GemMapCoordinator.swift
//  GeoSeek
//
//  Created by morse on 3/4/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

// protocol

import UIKit

protocol GemsMapCoordinatorDelegate {
    func goToCreateGemController()
}

class GemsMapCoordinator: BaseCoordinator {
    
    let window: UIWindow
    var navigationController: UINavigationController?
    
    var delegate: GemsMapCoordinatorDelegate?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        print("MainCoordinator.toVCOne: change views")
        
        var viewController = GemsMapVC.instantiate()
//        navigationController = UINavigationController()
        viewController.coordinator = self
        window.rootViewController = navigationController
        navigationController?.isNavigationBarHidden = true
        
        
        if let vc = navigationController?.viewControllers.first {
            print(vc.description)
        } else {
            let vc = GemsMapVC.instantiate()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func navigateToCreateGemCoordinator() {
        print("GemsMapCoordinator")
        delegate?.goToCreateGemController()
    }
}
