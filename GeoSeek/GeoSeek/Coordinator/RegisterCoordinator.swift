//
//  RegisterCoordinator.swift
//  GeoSeek
//
//  Created by morse on 3/13/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import CoreData

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
    
    func logInAfterRegistering(user: User) {
        guard let username = user.username,
            let password = user.password else { return }
        NetworkController.shared.signIn(with: username, password: password) { result in
            switch result {
            case .failure(let error):
                print("There was an error logging in after registering: \(error)")
            case .success(let message):
                print("Logged in after registering! Message: \(message)")
                self.printToken()
            }
        }
    }
    
    func printToken() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let context = CoreDataStack.shared.mainContext
        do {
            let user = try context.fetch(fetchRequest).first
            print("User's token: \(user?.token)")
        } catch {
            print("No user :(")
        }
    }
}


extension RegisterCoordinator: RegisterUserDelegate {
    func registerUser(with username: String, password: String, email: String) {
        NetworkController.shared.register(with: username, password: password, email: email) { result in
            switch result {
            case .failure(let error):
                print("Registration error: \(error)")
            case .success(let user):
                self.logInAfterRegistering(user: user)
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
