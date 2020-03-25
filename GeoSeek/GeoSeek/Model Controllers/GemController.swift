//
//  GemController.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 2/21/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation
import CoreData
import Mapbox

class GemController {
    
    var gems: [Gem] = []
    var recentGem: Gem?
    var gemDictionary: [Int:Gem] = [:]
    
    func createGem(with gem: GemRepresentation) {
        NetworkController.shared.createGem(from: gem) { result in
            switch result {
            case .failure(let error):
                print("Error creating gem: \(error)")
            case .success(let gem):
                print("Yay! Created \(gem.title ?? "wut?")")
                self.gems.append(gem)
                self.recentGem = gem
            }
        }
    }
    
    func fetchGemsFromServer() {
        NetworkController.shared.fetchGems { (result) in
            switch result {
            case .failure(let error):
                print("Error fetching gems: \(error)")
            case .success(let gems):
                self.gems = gems
            }
        }
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
