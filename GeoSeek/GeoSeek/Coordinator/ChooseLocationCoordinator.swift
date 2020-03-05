//
//  ChooseLocationCoordinator.swift
//  GeoSeek
//
//  Created by morse on 3/4/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

class ChooseLocationCoordinator: BaseCoordinator {
    let window: UIWindow
    var navigationController: UINavigationController?
    
//    var gemLat: Double?
//    var gemLong: Double?
    
    // delegate
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        print("MainCoordinator.toVCOne: change views")
        
//        navigationController = UINavigationController()
//        window.rootViewController = navigationController
//        navigationController?.isNavigationBarHidden = true
//        
//        
//        
//
//        if let vc = navigationController?.viewControllers.first {
//            print(vc.description)
//        } else {
//            let vc = ChooseLocationVC()
//            vc.coordinator = self
//            navigationController?.pushViewController(vc, animated: true)
//        }
        
        DispatchQueue.main.async {
            let mapVC = ChooseLocationVC()
            mapVC.coordinator = self
            mapVC.modalPresentationStyle = .overFullScreen
            mapVC.modalTransitionStyle = .coverVertical
//            self.navControllers[1].present(mapVC, animated: true)
        }
    }
}
