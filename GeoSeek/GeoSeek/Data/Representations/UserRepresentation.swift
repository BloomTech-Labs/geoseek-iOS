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

struct ReturnedRegister: Codable {
    let id: Int
}

struct ReturnedUser: Codable {
    let userId: Int
    let token: String
    let email: String
}

struct CompletedBy: Codable {
    let gemId: Int
    let completedAt: String
    let completedBy: Int
    let difficulty: Int
    let comments: String
}
