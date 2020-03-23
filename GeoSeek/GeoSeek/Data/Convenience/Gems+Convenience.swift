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
    
    var gemRepresentation: GemRepresentation? {
        
        guard let description = gemDesc,
            let title = title else { return nil }
        
        return GemRepresentation(difficulty: difficulty, description: description, id: Int(id), latitude: latitude, longitude: longitude, title: title, createdByUser: Int(createdByUser))
    }
    
    @discardableResult convenience init(representation: GemRepresentation, context: NSManagedObjectContext = .context) {
        self.init(title: representation.title,
                  gemDesc: representation.description,
                  difficulty: representation.difficulty,
                  id: representation.id,
                  latitude: representation.latitude,
                  longitude: representation.longitude,
                  createdByUser: representation.createdByUser,
                  context: context)
    }
    
    @discardableResult convenience init(title: String,
                                        gemDesc: String,
                                        difficulty: Double?,
                                        id: Int?,
                                        latitude: Double,
                                        longitude: Double,
                                        createdByUser: Int,
                                        context: NSManagedObjectContext) {
        
        self.init(context: context)
        
        if let id = id {
            self.id = Int16(id)
        }
        if let difficulty = difficulty {
            self.difficulty = difficulty
        }
        self.title = title
        self.gemDesc = gemDesc
        self.latitude = latitude
        self.longitude = longitude
        self.createdByUser = Int16(createdByUser)
    }
}
