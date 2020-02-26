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
                                        id: Int,
                                        latitude: Double,
                                        longitude: Double,
                                        createdByUser: Int,
                                        context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
        self.gemDesc = gemDesc
        self.difficulty = difficulty
        self.id = Int16(id)
        self.latitude = latitude
        self.longitude = longitude
        self.createdByUser = Int16(id)
    }
}
