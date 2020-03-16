//
//  RegisterVC.swift
//  GeoSeek
//
//  Created by morse on 3/13/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

protocol RegisterUserDelegate {
    func registerUser(with username: String, password: String, email: String)
    func logIn()
}

class RegisterVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var delegate: RegisterUserDelegate?
    var passwordIsValid: Bool = false
    var emailIsValid: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.isEnabled = false
        signUpButton.backgroundColor = .systemGray2
        configureTextFields()
    }
    
    func configureTextFields() {
        let textFields = [usernameTextField, emailTextField, passwordTextField]
        for textField in textFields {
            textField?.delegate = self
            textField?.addTarget(self, action: #selector(checkFormat(textField:)), for: .editingChanged)
        }
        usernameTextField.becomeFirstResponder()
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        attemptToRegister()
    }
    
    
    
    func attemptToRegister() {
        guard let username = usernameTextField.text,
        let password = passwordTextField.text,
        let email = emailTextField.text,
        !username.isEmpty,
        passwordIsValid,
        emailIsValid else { return }
        
        delegate?.registerUser(with: username, password: password, email: email)
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        delegate?.logIn()
    }
    
    @objc func checkFormat(textField: UITextField) {
        switch textField {
        case emailTextField:
            guard let email = emailTextField.text else { return }
            emailIsValid = email.isValidEmail
        case passwordTextField:
            guard let password = passwordTextField.text else { return }
            passwordIsValid = password.isValidPassword
        default: return
        }
        if emailIsValid && passwordIsValid {
            signUpButton.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.2509803922, blue: 0.462745098, alpha: 1)
            signUpButton.isEnabled = true
        }
    }
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == passwordTextField {
            attemptToRegister()
        }
        return true
    }
}

