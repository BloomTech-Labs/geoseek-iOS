//
//  RegisterCoordinator.swift
//  GeoSeek
//
//  Created by morse on 3/13/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

class RegisterCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController?
    var registerVC: RegisterVC?
    
    override func start() {
        showRegisterVC()
    }
    
    func showRegisterVC() {
        registerVC = RegisterVC()
        registerVC?.delegate = self
        
    }
}

