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
    var token: String
}

struct ReturnedUser: Codable {
    let userID: Int
    let token: String
    let email: String
}

struct CompletedBy {
    let gemId: Int
    let completedAt: String
    let completedBy: Int
    let difficulty: Int
    let comments: String
}
