//
//  GemRepresentation.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 2/25/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation

struct GemRepresentation: Codable {
    
    var difficulty: Double
    var description: String
    var id: Int
    var latitude: Double
    var longitude: Double
    var title: String
    var createdByUser: Int
    
}
