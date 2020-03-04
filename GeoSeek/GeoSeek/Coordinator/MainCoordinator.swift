//
//  MainCoordinator.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 2/25/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import Mapbox

class MainCoordinator: Coordinator {
   
    
    
    var window: UIWindow
    var childCoordinators = [Coordinator]()
    var navControllers: [UINavigationController] = []
    var gemController = GemController()
    var addGemCoordinates: CLLocation? {
        didSet {
            print("hi")
        }
    }
    var addGemLat: Double?
    var addGemLong: Double?
    
    
    init(window: UIWindow) {
        let navController1 = UINavigationController()
        let navController2 = UINavigationController()
        let navController3 = UINavigationController()
        let navController4 = UINavigationController()
//        let navControllerMap = UINavigationController()
        
        navControllers = [navController1, navController2, navController3, navController4/*, navControllerMap*/]
        
        self.window = window
    }
    
    func start() {
        window.makeKeyAndVisible()
//        toVCOne()
       // mapXibView()
        toLandingPageVC()
        
    }
    
    func toVCOne() {
        print("MainCoordinator.toVCOne: change views")
        window.rootViewController = navControllers[0]
        navControllers[0].isNavigationBarHidden = true
        

        if let vc = navControllers[0].viewControllers.first {
            print(vc.description)
        } else {
            let vc = ViewController.instantiate()
            vc.coordinator = self
            navControllers[0].pushViewController(vc, animated: true)
        }
    }
    
    func toVCTwo() {
        window.rootViewController = navControllers[1]

        if let vc = navControllers[1].viewControllers.first {
            print(vc.description)
        } else {
            let vc = SecondViewController.instantiate()
            vc.coordinator = self
            navControllers[1].pushViewController(vc, animated: true)
            print("Brandi made a new View Controller")
        }
    }
    
    func mapXibView() {
        window.rootViewController = navControllers[3]
    }
    
    func presentGSMapViewControllerOnMainThread() {
        DispatchQueue.main.async {
            let mapVC = GSMapViewController()
            mapVC.coordinator = self
            mapVC.modalPresentationStyle = .overFullScreen
            mapVC.modalTransitionStyle = .coverVertical
            self.navControllers[1].present(mapVC, animated: true)
        }
    }
    
    func toLandingPageVC() {
        window.rootViewController = navControllers[2]

        if let vc = navControllers[2].viewControllers.first {
            print(vc.description)
        } else {
            let vc = LandingPageVC.instantiate()
            vc.coordinator = self
            navControllers[2].pushViewController(vc, animated: true)
            print("Brandi made a LandingPageVC")
        }
    }

}
