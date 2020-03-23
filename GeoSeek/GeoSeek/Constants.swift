//
//  Constants.swift
//  GeoSeek
//
//  Created by morse on 3/19/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

enum Colors {
    static let gsPink: UIColor = #colorLiteral(red: 0.9568627451, green: 0.2509803922, blue: 0.462745098, alpha: 1)
}

enum FetchError: String, Error {
    case badData = "There was a data error. Please try again." // TODO Fix error messages
    case badResponse = "There was a bad response. Please try again."
    case badEncode = "There was a problem encoding. Please try again."
    case otherError = "Something went wrong. Please try again."
    case noUser = "Please log in."
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum UserAction: String {
    case login = "login"
    case register = "register"
}
