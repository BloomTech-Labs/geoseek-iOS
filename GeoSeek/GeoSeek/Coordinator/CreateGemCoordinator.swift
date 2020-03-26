//
//  CreateGemCoordinator.swift
//  GeoSeek
//
//  Created by morse on 3/4/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

protocol CreateGemCoordinatorDelegate {
    func presentGemsMap()
    func reqeustLogIn()
}

class CreateGemCoordinator: BaseCoordinator {
    var createGemVC = CreateGemVC.instantiate()
    var chooseYourLocationVC = ChooseYourLocationVC.instantiate()
    
    var navigationController: UINavigationController?
    var locationManager: CLLocationManager?
    var gemController: GemController?
    
    var delegate: CreateGemCoordinatorDelegate?
    var gemLocation: CLLocationCoordinate2D?
    
    override func start() {
        chooseYourLocationVC.delegate = self
        if loggedIn() {
            navigationController?.present(chooseYourLocationVC, animated: true, completion: nil)
        } else {
            delegate?.reqeustLogIn()
        }
    }
    
    func toGemsMapViewController() {
        delegate?.presentGemsMap()
    }
    
    func toCreateGemVC() {
        createGemVC.delegate = self
        createGemVC.coordinator = self
        createGemVC.gemLocation = gemLocation
        navigationController?.present(createGemVC, animated: true) // Can we make this go slower?
    }
    
    func loggedIn() -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let context = CoreDataStack.shared.mainContext
        do {
            let possibleUsers = try context.fetch(fetchRequest)
            if !(possibleUsers.first?.token?.isEmpty ?? true) {
                return true
            }
        } catch {
            return false
        }
        return false
    }
}

extension CreateGemCoordinator: CreateGemDelegate {
    func createGem(_ gem: GemRepresentation) {
        gemController?.createGem(with: gem)
        
        delegate?.presentGemsMap()
    }
    
    func getGemLocation() {
        let mapVC = ChooseLocationVC()
        mapVC.coordinator = self
        mapVC.delegate = self
        mapVC.gemController = gemController
        mapVC.locationManager = locationManager
        mapVC.modalTransitionStyle = .coverVertical
        self.navigationController?.present(mapVC, animated: true)
    }
}

extension CreateGemCoordinator: SetLocationDelegate {
    func didSetLocation(to location: CLLocationCoordinate2D) {
        gemLocation = location
        toCreateGemVC()
    }
}

extension CreateGemCoordinator: ChooseLocationDelegate {
    func locationWasChosen(with type: LocationType) {
        switch type {
        case .current:
            gemLocation = locationManager?.location?.coordinate
            toCreateGemVC()
        case .choose:
            getGemLocation()
        }
    }
}
