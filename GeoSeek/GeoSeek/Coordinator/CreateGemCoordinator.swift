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
    var navigationController: UINavigationController?
    var createGemVC = CreateGemVC.instantiate()
    var delegate: CreateGemCoordinatorDelegate?
    var userLocation: CLLocationCoordinate2D?
    var gemController: GemController?
    var chooseYourLocationVC = ChooseYourLocationVC.instantiate()
    
    override func start() {
        navigationController?.isNavigationBarHidden = true
        
//        createGemVC.coordinator = self
//        createGemVC.delegate = self
//        createGemVC.userLocation = userLocation
        chooseYourLocationVC.delegate = self
//
//        navigationController?.present(createGemVC, animated: true, completion: nil)
         navigationController?.present(chooseYourLocationVC, animated: true, completion: nil)
    }
    
    func toGemsMapViewController() {
        delegate?.presentGemsMap()
    }
}

extension CreateGemCoordinator: CreateGemDelegate {
    func createGem(_ gem: GemRepresentation) {
        gemController?.createGem(with: gem)
    }
    
    func getGemLocation() {
        print("Made it to the Gem Location() in the coordinator.")
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
