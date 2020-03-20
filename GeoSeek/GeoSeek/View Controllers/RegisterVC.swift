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
    func dismiss()
}

class RegisterVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordField: PasswordView!
    @IBOutlet weak var signUpButton: UIButton!
    
    var keyboardDismissTapGestureRecognizer: UITapGestureRecognizer!
    var currentYShiftForKeyboard: CGFloat = 0
    var delegate: RegisterUserDelegate?
    var passwordIsValid: Bool = false
    var emailIsValid: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDismissKeyboardTapGesture()
        configureTextFields()
        updateUI()
    }
    
    func configureTextFields() {
        let textFields = [usernameTextField, emailTextField, passwordField.textField]
        for textField in textFields {
            textField?.delegate = self
            textField?.addTarget(self, action: #selector(checkFormat(textField:)), for: .editingChanged)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        attemptToRegister()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        delegate?.dismiss()
    }
    
    
    func attemptToRegister() {
        guard let username = usernameTextField.text,
            let password = passwordField.textField.text,
            let email = emailTextField.text,
            !username.isEmpty,
            passwordIsValid,
            emailIsValid else { return }
        
        delegate?.registerUser(with: username, password: password, email: email)
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        delegate?.logIn()
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        keyboardDismissTapGestureRecognizer = tap
    }
    
    @objc func checkFormat(textField: UITextField) {
        switch textField {
        case emailTextField:
            guard let email = emailTextField.text else { return }
            emailIsValid = email.isValidEmail
        case passwordField.textField:
            guard let password = passwordField.textField.text else { return }
            passwordIsValid = password.isValidPassword
        default: return
        }
        updateUI()
    }
    
    @objc func stopEditingTextInput() {
        if let usernameTextField = self.usernameTextField {
            usernameTextField.resignFirstResponder()
        } else if let passwordTextField = self.passwordField.textField {
            passwordTextField.resignFirstResponder()
        }
        
        guard keyboardDismissTapGestureRecognizer.isEnabled else { return }
        keyboardDismissTapGestureRecognizer.isEnabled = false
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        keyboardDismissTapGestureRecognizer.isEnabled = true
        var keyboardSize: CGRect = .zero
        
        if let keyboardRect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            keyboardRect.height != 0 {
            keyboardSize = keyboardRect
        } else if let keyboardRect = notification.userInfo?["UIKeyboardBoundsUserInfoKey"] as? CGRect {
            keyboardSize = keyboardRect
        }
        
        if self.view.frame.origin.y == 0 {
            let yShift = yShiftWhenKeyboardAppearsFor(textInput: signUpButton, keyboardSize: keyboardSize, nextY: keyboardSize.height)
            currentYShiftForKeyboard = yShift
            view.frame.origin.y -= yShift
        }
    }
    
    @objc func yShiftWhenKeyboardAppearsFor(textInput: UIView, keyboardSize: CGRect, nextY: CGFloat) -> CGFloat {
        
        let textFieldOrigin = self.view.convert(textInput.frame, from: textInput.superview!).origin.y
        let textFieldBottomY = textFieldOrigin + textInput.frame.size.height
        let maximumY = self.view.frame.height - (keyboardSize.height + view.safeAreaInsets.bottom)
        
        if textFieldBottomY > maximumY {
            return textFieldBottomY - maximumY
        } else {
            return 0
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += currentYShiftForKeyboard
        }
        stopEditingTextInput()
    }
    
    func updateUI() {
        if emailIsValid && passwordIsValid && !(usernameTextField.text?.isEmpty ?? true) {
            signUpButton.backgroundColor = Colors.gsPink// #colorLiteral(red: 0.9568627451, green: 0.2509803922, blue: 0.462745098, alpha: 1)
            signUpButton.isEnabled = true
        } else {
            signUpButton.backgroundColor = .systemGray3
            signUpButton.isEnabled = false
        }
    }
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == passwordField.textField {
            attemptToRegister()
        }
        return true
    }
}

