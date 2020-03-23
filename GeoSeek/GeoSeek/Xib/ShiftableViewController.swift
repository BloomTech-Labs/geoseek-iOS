//
//  ShiftableViewController.swift
//  GeoSeek
//
//  Created by morse on 3/23/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

class ShiftableViewController: UIViewController {
    
    var keyboardDismissTapGestureRecognizer: UITapGestureRecognizer!
    var currentYShiftForKeyboard: CGFloat = 0
    var bottomButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        createDismissKeyboardTapGesture()
        setUpNotifications()
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
            guard let bottomButton = bottomButton else { return }
            let yShift = yShiftWhenKeyboardAppearsFor(textInput: bottomButton, keyboardSize: keyboardSize, nextY: keyboardSize.height)
            currentYShiftForKeyboard = yShift
            view.frame.origin.y -= yShift
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += currentYShiftForKeyboard
        }
        stopEditingTextInput()
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
    
    @objc func stopEditingTextInput() {
        guard keyboardDismissTapGestureRecognizer.isEnabled else { return }
        keyboardDismissTapGestureRecognizer.isEnabled = false
    }
}
