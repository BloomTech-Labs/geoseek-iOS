//
//  MainCoordinator.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 2/25/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import Mapbox
import CoreData
import CoreLocation

class MainCoordinator: BaseCoordinator {
    
    var window: UIWindow
    
    var navigationController = UINavigationController()
    let locationManager = CLLocationManager()
    let gemController = GemController()
    var gemsMapVC = GemsMapVC()
    let gemsMapCoordinator = GemsMapCoordinator()
    
    var logInCoordinator: LogInCoordinator?
    var registerCoordinator: RegisterCoordinator?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        window.makeKeyAndVisible()
        navigationController.isNavigationBarHidden = true
        window.rootViewController = self.navigationController
        
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            reqeustLogIn()
//            toGemsMapViewController()
        } else {
            toLandingPageVC()
        }
    }
    
    // This is here for when we actually add a log out button
    func logOut() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let context = CoreDataStack.shared.mainContext
        let possibleUsers = try? context.fetch(fetchRequest)
        if let users = possibleUsers {
            for user in users {
                context.delete(user)
                try? context.save()
            }
        }
    }
    
    func toGemsMapViewController() {
        gemsMapCoordinator.navigationController = navigationController
        gemsMapCoordinator.delegate = self
        gemsMapCoordinator.locationManager = locationManager
        gemsMapCoordinator.gemController = gemController
        gemsMapCoordinator.start()
    }
    
    func toLandingPageVC() {
        let vc = LandingPageVC.instantiate()
        vc.locationManager = locationManager
        vc.coordinator = self
        vc.delegate = self
        navigationController.pushViewController(vc, animated: true)
    }
}

extension MainCoordinator: GemsMapCoordinatorDelegate {
    func goToCreateGemController() {
        let createGemCoordinator = CreateGemCoordinator()
        createGemCoordinator.gemController = gemController
        createGemCoordinator.navigationController = navigationController
        createGemCoordinator.delegate = self
        createGemCoordinator.locationManager = locationManager
        createGemCoordinator.start()
    }
}

extension MainCoordinator: CreateGemCoordinatorDelegate {
    func reqeustLogIn() {
        didRequestLogIn()
    }
    
    func presentGemsMap() {
        gemsMapCoordinator.start()
        navigationController.topViewController?.dismiss(animated: true)
    }
}

extension MainCoordinator: LandingPageDelegate {
    func showMapVC() {
        toGemsMapViewController()
    }
}

extension MainCoordinator: RegisterCoordinatorDelegate {
    func didRequestLogIn() {
        logInCoordinator = LogInCoordinator()
        logInCoordinator?.delegate = self
        logInCoordinator?.navigationController = navigationController
        logInCoordinator?.start()
    }
}

extension MainCoordinator: LoginCoordinatorDelegate {
    func didRequestRegister() {
        registerCoordinator = RegisterCoordinator()
        registerCoordinator?.delegate = self
        registerCoordinator?.navigationController = navigationController
        registerCoordinator?.start()
    }
}
