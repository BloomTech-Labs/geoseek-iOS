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
    func dismiss()
}

class LogInVC: ShiftableViewController, KeyboardShiftable, Storyboarded {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordField: PasswordView!
    @IBOutlet weak var signInButton: UIButton!
    
    var delegate: LogInDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDelegates()
        setBottomButton()
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        logIn()
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        delegate?.register()
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        delegate?.dismiss()
    }
    
    func logIn() {
        guard let username = usernameTextField.text,
            let password = passwordField.textField.text,
            !username.isEmpty,
            !password.isEmpty else { return }
        
        delegate?.attemptLogIn(with: username, password: password)
    }
    
    func setUpDelegates() {
        usernameTextField.delegate = self
        passwordField.textField.delegate = self
    }
    
    func setBottomButton() {
        bottomButton = signInButton
    }
}

extension LogInVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == passwordField.textField {
            logIn()
        }
        return true
    }
}
