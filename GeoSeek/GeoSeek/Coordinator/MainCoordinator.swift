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
    var tabBarController: UITabBarController
    //var tabBarChildren = []()
    
    init(tabBarController: UITabBarController = UITabBarController(), window: UIWindow) {
        self.tabBarController = tabBarController
        self.window = window
    }
    
    func start() {
        let secondNavigationController = UINavigationController()
        tabBarController.viewControllers = [ secondNavigationController]
        
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
//        let vc = ViewController.instantiate()
//        vc.title = "GeoSeek!"
//        vc.tabBarItem.image = UIImage(systemName: "mappin.and.ellipse")
//        vc.coordinator = self
      
        
        let secondVC = ViewController.instantiate()
        //secondVC.title = "Hide!!!"
        secondNavigationController.setNavigationBarHidden(true, animated: false)
        secondVC.coordinator = self
        secondVC.tabBarItem.image = UIImage(systemName: "plus")
        secondNavigationController.pushViewController(secondVC, animated: true)
    }

}
