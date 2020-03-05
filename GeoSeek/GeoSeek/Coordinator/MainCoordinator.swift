//
//  MainCoordinator.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 2/25/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import Mapbox

class MainCoordinator: BaseCoordinator {
    
    
    
    var window: UIWindow
    var navigationController = UINavigationController()
    var childCoordinators = [BaseCoordinator]()
    var navControllers: [UINavigationController] = []
    var gemController = GemController()
    let gemsMapCoordinator: GemsMapCoordinator
    var addGemCoordinates: CLLocation? {
        didSet {
            print("hi")
        }
    }
    
    init(window: UIWindow) {
        let navController1 = UINavigationController()
        let navController2 = UINavigationController()
        let navController3 = UINavigationController()
        //        let navControllerMap = UINavigationController()
        
        navControllers = [navController1, navController2, navController3/*, navControllerMap*/]
        
        self.window = window
        self.gemsMapCoordinator = GemsMapCoordinator(window: self.window)
    }
    
    override func start() {
//        window.makeKeyAndVisible()
        toGemsMapViewController()
    }
    
    func toGemsMapViewController() {
        
        // TODO add this coordinator to the array of child coordinators
//        childCoordinators.append(gemsMapCoordinator)
        gemsMapCoordinator.navigationController = navigationController
        gemsMapCoordinator.delegate = self
        gemsMapCoordinator.start()
    }
    
    func presentGSMapViewControllerOnMainThread() {
        
    }
}

extension MainCoordinator: GemsMapCoordinatorDelegate {
    func goToCreateGemController() {
        let createGemCoordinator = CreateGemCoordinator() //CreateGemCoordinator(window: window)
        createGemCoordinator.navigationController = navigationController
        createGemCoordinator.delegate = self
        createGemCoordinator.start()
    }
}

extension MainCoordinator: CreateGemCoordinatorDelegate {
    
    func presentChooseLocationVC() {
//        let chooseLocationCoordinator = ChooseLocationCoordinator(window: window)
//        chooseLocationCoordinator.start()
    }
    
    func presentGemsMap() {
        print("Delegate here")
//        toGemsMapViewController()
//        gemsMapCoordinator.start()
        navigationController.topViewController?.dismiss(animated: true)
    }
    
}
