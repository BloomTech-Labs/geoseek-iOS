//
//  UserRepresentation.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 2/25/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation

struct ReturnedRegister: Codable {
    let id: Int
}

struct ReturnedUser: Codable {
    let userId: Int
    let token: String
    let email: String
}

struct CompletedToSend: Codable {
    let gemId: Int
    let completedBy: Int
    let comments: String
}

struct ReceivedCompleted: Codable {
    let id: Int
    let gemId: Int
    let completedAt: String
    let completedBy: Int
    let comments: String
}
