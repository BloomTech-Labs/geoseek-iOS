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
                                        id: Int16,
                                        password: String,
                                        username: String,
                                        gems: [Gem]? = nil,
                                        context: NSManagedObjectContext) {
        self.init(context: context)
        self.email = email
        self.id = id
        self.password = password
        self.username = username
        
        if let gems = gems {
            self.gems = NSOrderedSet(array: gems)
        }
    }
}
