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
    func start() {
        preconditionFailure("A subclass must override start()")
    }
}
