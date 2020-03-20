//
//  LogInCoordinator.swift
//  GeoSeek
//
//  Created by morse on 3/13/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

protocol LoginCoordinatorDelegate {
    func didRequestRegister()
}

class LogInCoordinator: BaseCoordinator {
    var navigationController: UINavigationController?
    var logInVC = LogInVC.instantiate()
    var delegate: LoginCoordinatorDelegate?
    
    override func start() {
        showLogInVC()
    }
    
    func showLogInVC() {
        logInVC.delegate = self
        navigationController?.pushViewController(logInVC, animated: true)
    }
}

extension LogInCoordinator: LogInDelegate {
    
    func attemptLogIn(with username: String, password: String) {
        NetworkController.shared.signIn(with: username, password: password) { result in
            switch result {
            case .failure(_):
                self.showLogInFailedAlert()
            case .success(let message):
                print("Logged In: \(message)") // Do we want to show a success alert?
                DispatchQueue.main.async {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
    func register() {
        delegate?.didRequestRegister()
    }
    
    func dismiss() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func showLogInFailedAlert() {
        print("Problem logging in!")
        // This should be a custom class for all errors. It can take a string which can come from the error type. 
    }
}
