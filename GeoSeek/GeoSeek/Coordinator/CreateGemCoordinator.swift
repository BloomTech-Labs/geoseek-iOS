//
//  CreateGemCoordinator.swift
//  GeoSeek
//
//  Created by morse on 3/4/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import CoreLocation

protocol CreateGemCoordinatorDelegate {
    func presentChooseLocationVC()
    func presentGemsMap()
}

class CreateGemCoordinator: BaseCoordinator {
//    let window: UIWindow
    var navigationController: UINavigationController?
    var createGemVC = CreateGemVC.instantiate()
    var delegate: CreateGemCoordinatorDelegate?
    var userLocation: CLLocationCoordinate2D?
    
    override func start() {
        navigationController?.isNavigationBarHidden = true
        
        createGemVC.coordinator = self
        createGemVC.delegate = self
        createGemVC.userLocation = userLocation
        
        navigationController?.pushViewController(createGemVC, animated: true)
    }
    
    func toGemsMapViewController() {
        delegate?.presentGemsMap()
    }
}

extension CreateGemCoordinator: CreateGemDelegate {
    func createGem(_ gem: GemRepresentation) {
        NetworkController.shared.createGem(from: gem) { result in
            switch result {
            case .failure(let error):
                print("Error creating gem: \(error)")
            case .success(let gem):
                print("Yay! Created \(gem.title ?? "wut?")")
            }
        }
    }
    
    func getGemLocation() {
        let mapVC = ChooseLocationVC()
        mapVC.coordinator = self
        mapVC.delegate = self
        mapVC.modalPresentationStyle = .overFullScreen
        mapVC.modalTransitionStyle = .coverVertical
        self.navigationController?.present(mapVC, animated: true)
    }
}

extension CreateGemCoordinator: SetLocationDelegate {
    func didSetLocation(to location: CLLocationCoordinate2D) {
        print("CreateGemCoordinator.didSetLocation")
        createGemVC.gemLocation = location
    }
}
