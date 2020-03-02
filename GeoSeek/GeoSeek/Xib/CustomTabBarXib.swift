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
    
    weak var coordinator: MainCoordinator?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "CustomTabBarXib", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.backgroundColor = .gray
    }
    
    @IBAction func addGemMapViewButtonTapped(_ sender: Any) {
        coordinator?.toVCOne()
        print("add gem map")
    }
    
    @IBAction func twoButtonTapped(_ sender: Any) {
        coordinator?.toVCTwo()
        print("Two Two")
    }
    
}
