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

class RegisterVC: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var delegate: RegisterUserDelegate?
    var passwordIsValid: Bool = false
    var emailIsValid: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func registerTapped(_ sender: Any) {
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
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.text ?? "none")
        
        switch textField {
        case emailTextField:
            guard let email = emailTextField.text else { return }
            emailIsValid = email.isValidEmail
        case passwordTextField:
            guard let password = passwordTextField.text else { return }
            passwordIsValid = password.isValidPassword
        default: return
        }
    }
    
    // Maybe need the below method instead of DidBeginEditing TBD once we have a storyboard view
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //        let oldText = textField.text!
    //        let stringRange = Range(range, in: oldText)!
    //        let newText = oldText.replacingCharacters(in: stringRange, with: string)
    //        self.determineStrength(of: newText)
    //        return true
    //    }
}

