//
//  Gems+Convenience.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 2/21/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation
import CoreData

extension Gem {
    
    @discardableResult convenience init(title: String,
                                        gemDesc: String,
                                        difficulty: Double,
                                        id: Int16,
                                        latitude: Double,
                                        longitude: Double,
                                        createdBy: User,
                                        context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
        self.gemDesc = gemDesc
        self.difficulty = difficulty
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.createdBy = createdBy
    }
}
