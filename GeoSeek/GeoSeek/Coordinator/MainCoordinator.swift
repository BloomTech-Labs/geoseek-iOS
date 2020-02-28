//
//  MainCoordinator.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 2/25/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

class MainCoordinator {
        
    var window: UIWindow
    var childCoordinators = [Coordinator]()
    var navControllers: [UINavigationController] = []
    
    init(window: UIWindow) {
        let navController1 = UINavigationController()
        let navController2 = UINavigationController()
        let navController3 = UINavigationController()
        
        navControllers = [navController1, navController2, navController3]
        
        self.window = window
    }
    
    
//    init(tabBarController: UITabBarController = UITabBarController(), window: UIWindow) {
//        self.tabBarController = tabBarController
//        self.window = window
//    }
    
    func start() {
        window.makeKeyAndVisible()
        
    }
    
    func toVCOne() {
        window.rootViewController = navControllers[0]
        
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

}
