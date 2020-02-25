//
//  MainCoordinator.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 2/25/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
        
    var window: UIWindow
    var childCoordinators = [Coordinator]()
    var tabBarController: UITabBarController
    var navigationController: UINavigationController
    
    init(tabBarController: UITabBarController = UITabBarController(), navigationController: UINavigationController = UINavigationController(), window: UIWindow) {
        self.tabBarController = tabBarController
        self.navigationController = navigationController
        self.window = window
    }
    
    func start() {
        let secondNavigationController = UINavigationController()
        tabBarController.viewControllers = [navigationController, secondNavigationController]
        
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        let vc = ViewController.instantiate()
        vc.title = "GeoSeek!"
        vc.tabBarItem.image = UIImage(systemName: "mappin.and.ellipse")
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
        
        let secondVC = ViewController.instantiate()
        secondVC.title = "Hide!!!"
        secondVC.coordinator = self
        secondVC.tabBarItem.image = UIImage(systemName: "plus")
        secondNavigationController.pushViewController(secondVC, animated: true)
    }

}
