//
//  NavButtonsXib.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 3/12/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

class NavButtonsXib: UIView, Storyboarded {
    
    @IBOutlet weak var navButtonsView: UIView!
    @IBOutlet weak var userMenuButton: UIButton!
    
    var delegate: GemsMapCoordinatorDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        let nib = UINib(nibName: "NavButtonsXib", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(navButtonsView)
        
        navButtonsView.frame = self.bounds
        navButtonsView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        navButtonsView.backgroundColor = .clear
        
        let buttonColor = #colorLiteral(red: 0.9568627451, green: 0.2509803922, blue: 0.462745098, alpha: 1)
        
        navButtonsView.backgroundColor = buttonColor
        navButtonsView.layer.cornerRadius = 20
    }
    
    @IBAction func userMenuButtonTapped(_ sender: Any) {
        delegate?.showMenuVC()
    }
    
}
