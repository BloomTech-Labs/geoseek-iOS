//
//  URLRequest+Extension.swift
//  GeoSeek
//
//  Created by morse on 3/21/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation

extension URLRequest {
    static func gsGemURL(from url: URL, with method: HTTPMethod) -> URLRequest {
        let endpoint = url.appendingPathComponent("gems")
        var request = URLRequest(url: endpoint)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    static func gsUserURL(from url: URL, with method: HTTPMethod, and userAction: UserAction, for user: User? = nil) -> URLRequest {
        var url = url
            .appendingPathComponent("users")
            .appendingPathComponent(userAction.rawValue)
        if let user = user {
            url = url.appendingPathComponent("\(user.id)")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    static func gsCompletedURL(from url: URL, with method: HTTPMethod, and user: User) -> URLRequest {
        let url = url
            .appendingPathComponent("completed")
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
