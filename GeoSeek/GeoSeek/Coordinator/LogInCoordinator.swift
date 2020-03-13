//
//  LogInCoordinator.swift
//  GeoSeek
//
//  Created by morse on 3/13/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

class LogInCoordinator: BaseCoordinator {
    var navigationController: UINavigationController?
    var logInVC = LogInVC.instantiate()
    
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
            case .failure(let error):
                print("Problem logging in: \(error)")
            case .success(let message):
                print("Logged In: \(message)")
            }
        }
        logInVC.dismiss(animated: true, completion: nil)
    }
}
