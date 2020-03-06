//
//  CustomTabBarXib.swift
//  GeoSeek
//
//  Created by Jerry haaser on 2/28/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

class CustomTabBarXib: UIView, Storyboarded {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var addGemMapViewButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    
    var delegate: GemsMapCoordinatorDelegate? {
        didSet {
            print("TAbBar.delegate", delegate)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        print("CustomTabBarXib created")
        
        let nib = UINib(nibName: "CustomTabBarXib", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.backgroundColor = .clear
        
        addGemMapViewButton.backgroundColor = .white
    }
    
    @IBAction func addGemMapViewButtonTapped(_ sender: Any) {

        delegate?.goToCreateGemController()   //navigateToCreateGemCoordinator()//delegate?.navigateToCreateGemController()
        print("Show add gem")

    }
    
    @IBAction func twoButtonTapped(_ sender: Any) {
//        coordinator?.toGemsMapViewController()
//        coordinator?.delegate?.navigateToCreateGemController()
        print("Two Two")
    }
    
}
