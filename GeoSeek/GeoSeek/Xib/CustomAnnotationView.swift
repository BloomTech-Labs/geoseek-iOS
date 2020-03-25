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
    
    var imageView: UIImageView!

    required init(reuseIdentifier: String?, image: UIImage) {
        super.init(reuseIdentifier: reuseIdentifier)

        self.imageView = UIImageView(image: image)
        self.addSubview(self.imageView)
        self.frame = self.imageView.frame
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
