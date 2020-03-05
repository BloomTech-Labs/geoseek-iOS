//
//  BaseCoordinator.swift
//  GeoSeek
//
//  Created by morse on 3/4/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation
import CoreLocation

class BaseCoordinator {
    
//    let id: String // here
    var childController: [Coordinator] = []
    
    var gemLat: Double? = 0
    var gemLong: Double? = 0
//    init(id: String) { // here
//        self.id = id
//    }
//    var userLocationLat: CLLocationDegrees?
//    var userLocationLong: CLLocationDegrees?
//    var setLocation: CLLocation?
    
    func start() {
        preconditionFailure("A subclass must override start()")
    }
    
}
