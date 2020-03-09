//
//  UserRepresentation.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 2/25/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation

struct UserRepresentation: Codable {
    
    var email: String
    var id: Int
    var password: String?
    var username: String
}
