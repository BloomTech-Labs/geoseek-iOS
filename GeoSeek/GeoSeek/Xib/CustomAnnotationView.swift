//
//  CustomAnnotationView.swift
//  GeoSeek
//
//  Created by morse on 3/2/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation
import Mapbox

class CustomAnnotationView: MGLAnnotationView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.width / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let animation = CABasicAnimation(keyPath: "borderWidth")
        animation.duration = 0.3
        layer.borderWidth = selected ? bounds.width / 3 : 2
        layer.add(animation, forKey: "borderWidth")
    }
}
