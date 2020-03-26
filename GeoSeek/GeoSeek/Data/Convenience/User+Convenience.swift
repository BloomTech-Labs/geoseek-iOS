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
    
    @discardableResult convenience init(email: String,
                                        id: Int,
                                        password: String,
                                        username: String,
                                        token: String = "",
                                        context: NSManagedObjectContext) {
        self.init(context: context)
        self.email = email
        self.id = Int16(id)
        self.token = token
        self.password = password
        self.username = username
        self.tokenTime = Date()
    }
}
