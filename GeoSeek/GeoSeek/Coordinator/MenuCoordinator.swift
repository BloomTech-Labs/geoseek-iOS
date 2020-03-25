//
//  MenuCoordinator.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 3/13/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

protocol MenuDelegate {
//    func logoutUser()
//    func goToMapView()
//    func goTo
}

class MenuCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController?
    var delegate: MenuDelegate?
    var menuVC = MenuVC.instantiate()
    
    
    
} 
