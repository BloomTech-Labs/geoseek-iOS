//
//  User+Convenience.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 2/21/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation
import CoreData

extension User {
    
    var userRepresentation: UserRepresentation? {
        
        guard let email = email,
            let username = username,
            let token = token else { return nil }
        
        return UserRepresentation(email: email, id: Int(id), password: password, username: username, token: token)
    }
    
    @discardableResult convenience init?(representation: UserRepresentation, context: NSManagedObjectContext = .context) {
        
        guard let password = representation.password else { return nil }
        
        self.init(email: representation.email, id: representation.id, password: password, username: representation.username, token: representation.token, context: context)
    }
    
    @discardableResult convenience init(email: String,
                                        id: Int,
                                        password: String,
                                        username: String,
                                        token: String = "",
                                        context: NSManagedObjectContext) {
        self.init(context: context)
        self.email = email
        self.id = Int16(id)
        self.password = password
        self.username = username
    }
}
