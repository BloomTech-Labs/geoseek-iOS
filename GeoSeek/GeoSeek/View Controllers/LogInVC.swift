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

class LogInVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordField: PasswordView!
    @IBOutlet weak var signInButton: UIButton!
    
    var delegate: LogInDelegate?
    var keyboardDismissTapGestureRecognizer: UITapGestureRecognizer!
    var currentYShiftForKeyboard: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDelegates()
        setUpNotifications()
        createDismissKeyboardTapGesture()
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        logIn()
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        register()
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
    
    func register() {
        delegate?.register()
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        keyboardDismissTapGestureRecognizer = tap
    }
    
    func setUpNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setUpDelegates() {
        usernameTextField.delegate = self
        passwordField.textField.delegate = self
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
            let yShift = yShiftWhenKeyboardAppearsFor(textInput: signInButton, keyboardSize: keyboardSize, nextY: keyboardSize.height)
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
