//
//  Coordinator.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 2/25/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
    
    var navigationController: UINavigationController { get set }
    
    func start()
}
