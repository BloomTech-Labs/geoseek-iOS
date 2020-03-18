//
//  PasswordView.swift
//  GeoSeek
//
//  Created by morse on 3/18/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

@IBDesignable
class PasswordView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let nib = UINib(nibName: "PasswordView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        
        addSubview(contentView)
        configureContentView()
        configureTextField()
    }
    
    @IBAction func hideButtonTapped(_ sender: Any) {
        textField.isSecureTextEntry.toggle()
        switch textField.isSecureTextEntry {
        case true:
            hideButton.setImage(UIImage(systemName: "eye"), for: .normal)
        case false:
            hideButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
    func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureTextField() {
        textField.isSecureTextEntry = true
    }
}
