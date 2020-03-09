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
    var gemLocation: CLLocationCoordinate2D?
    
    override func start() {
        navigationController?.isNavigationBarHidden = true

        chooseYourLocationVC.delegate = self
        
         navigationController?.present(chooseYourLocationVC, animated: true, completion: nil)
    }
    
    func toGemsMapViewController() {
        delegate?.presentGemsMap()
    }
    
    func toCreateGemVC() {
        createGemVC.delegate = self
        createGemVC.coordinator = self
        createGemVC.gemLocation = gemLocation
        navigationController?.present(createGemVC, animated: true)
    }
}

extension CreateGemCoordinator: CreateGemDelegate {
    func createGem(_ gem: GemRepresentation) {
        gemController?.createGem(with: gem)
        navigationController?.dismiss(animated: true)
    }
    
    func getGemLocation() {
        print("Made it to the Gem Location() in the coordinator.")
        let mapVC = ChooseLocationVC()
        mapVC.coordinator = self
        mapVC.delegate = self
//        mapVC.modalPresentationStyle = .overFullScreen
        mapVC.modalTransitionStyle = .coverVertical
        self.navigationController?.present(mapVC, animated: true)
    }
}

extension CreateGemCoordinator: SetLocationDelegate {
    func didSetLocation(to location: CLLocationCoordinate2D) {
        print("CreateGemCoordinator.didSetLocation")
        gemLocation = location
        toCreateGemVC()
    }
}

extension CreateGemCoordinator: ChooseLocationDelegate {
    func locationWasChosen(with type: LocationType) {
        switch type {
        case .current:
            gemLocation = userLocation
            toCreateGemVC()
        case .choose:
            getGemLocation()
//        @unknown default:
//            fatalError("LocationType Enum has a new type.")
        }
    }
}
