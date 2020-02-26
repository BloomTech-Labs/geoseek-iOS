//
//  GemController.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 2/21/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation
import CoreData

class GemController {
    
    static let shared = GemController()
    
    func createGem(title: String, gemDesc: String, difficulty: Double, id: Int, latitude: Double, longitude: Double, createdByUser: Int, context: NSManagedObjectContext = .context ) {
        
        Gem(title: title, gemDesc: gemDesc, difficulty: difficulty, id: id, latitude: latitude, longitude: longitude, createdByUser: createdByUser, context: context)
    }
    
    func loadGemsFromPersistentStore() -> [Gem] {
        let fetchRequest: NSFetchRequest<Gem> = Gem.fetchRequest()
        let moc = NSManagedObjectContext.context
        
        do {
            let gem = try moc.fetch(fetchRequest)
            return gem
        } catch {
            NSLog("There was an error fetching your Gems: \(error)")
            return []
        }
    }
    
    func saveGemsToPersistentStore() {
        let moc = NSManagedObjectContext.context
        
        do {
            try moc.save()
        } catch {
            NSLog("Error saving your Gem: \(error)")
            moc.reset()
        }
    }
}
