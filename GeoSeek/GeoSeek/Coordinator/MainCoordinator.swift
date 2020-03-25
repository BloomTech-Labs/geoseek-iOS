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
    
    var gemDetailVC: GemDetailVC?
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
            toGemsMapViewController()
            User.removeUser()
        } else {
            toLandingPageVC()
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
    func showGemDetails(for annotation: MGLAnnotation) {
        self.gemDetailVC = GemDetailVC.instantiate()
        if let gemDetailVC = gemDetailVC {
            gemDetailVC.delegate = self
            guard let gem = gemController.gemDictionary[annotation.hash] else { return }
            gemDetailVC.gem = gem
            navigationController.present(gemDetailVC, animated: true, completion: nil)
        }
    }
    
    func showMenuVC() {
        let menuVC = MenuVC.instantiate()
        menuVC.delegate = self
        navigationController.present(menuVC, animated: true)
    }
    
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

extension MainCoordinator: GemDetailDelegate {
    func markGemCompleted(_ gem: Gem, comments: String) {
        NetworkController.shared.markGemCompleted(gem, comments: comments) { result in
            switch result {
            case .failure(let error):
                print("Did not mark completed: \(error)")
            case .success(let message):
                print("Gem marked completed: \(message)")
                DispatchQueue.main.async {
                    self.gemDetailVC?.showLabel()
                    print("Label?")
                }
            }
        }
    }
}

extension MainCoordinator: MenuVCDelegate {
    func goToAddGemView() {
        goToCreateGemController()
    }
    
    func goToSignInView() {
        didRequestLogIn()
    }
}
