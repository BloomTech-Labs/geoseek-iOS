//
//  RegisterCoordinator.swift
//  GeoSeek
//
//  Created by morse on 3/13/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

protocol RegisterCoordinatorDelegate {
    func didRequestLogIn()
}

class RegisterCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController?
    var registerVC = RegisterVC.instantiate()
    var delegate: RegisterCoordinatorDelegate?
    
    override func start() {
        showRegisterVC()
    }
    
    func showRegisterVC() {
        registerVC.delegate = self
        navigationController?.pushViewController(registerVC, animated: true)
    }
}


extension RegisterCoordinator: RegisterUserDelegate {
    func registerUser(with username: String, password: String, email: String) {
        NetworkController.shared.register(with: username, password: password, email: email) { result in
            switch result {
            case .failure(let error):
                print("Registration error: \(error)")
            case .success(let message):
                print("Success: \(message)")
                DispatchQueue.main.async {
                    self.registerVC.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func logIn() {
        delegate?.didRequestLogIn()
        registerVC.dismiss(animated: true, completion: nil)
    }
}
