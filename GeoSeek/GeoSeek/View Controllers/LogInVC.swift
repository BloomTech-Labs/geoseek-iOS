//
//  LogInVC.swift
//  GeoSeek
//
//  Created by morse on 3/13/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

protocol LogInDelegate {
    func attemptLogIn(with username: String, password: String)
    func register()
}

class LogInVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var delegate: LogInDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        usernameTextField.becomeFirstResponder()
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        logIn()
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        register()
    }
    
    func logIn() {
        guard let username = usernameTextField.text,
            let password = passwordTextField.text,
            !username.isEmpty,
            !password.isEmpty else { return }
        
        delegate?.attemptLogIn(with: username, password: password)
    }
    
    func register() {
        delegate?.register()
    }
}

extension LogInVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == passwordTextField {
            logIn()
        }
        return true
    }
}
