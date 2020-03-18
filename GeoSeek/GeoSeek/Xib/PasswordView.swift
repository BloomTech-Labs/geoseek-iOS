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
//        configureContentView()
//        configureTextField()
    }
}
