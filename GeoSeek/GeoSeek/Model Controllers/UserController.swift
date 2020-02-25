//
//  UserController.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 2/21/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation
import CoreData

class UserController {
    
    static let shared = UserController()
    
    func createUser(email: String, id: Int16, password: String, username: String, gems: [Gem] = [], context: NSManagedObjectContext = .context) {
        
        User(email: email, id: id, password: password, username: username, gems: gems, context: context)
        
        saveUserToPersistentStore()
    }
    
    func loadUserFromPersistentStore() -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let moc = NSManagedObjectContext.context
        
        do {
            guard let user = try moc.fetch(fetchRequest).first else { return nil }
            return user
        } catch {
            NSLog("There was an error fetching user: \(error)")
            return nil
        }
    }
    
    func saveUserToPersistentStore() {
        let moc = NSManagedObjectContext.context
        
        do {
            try moc.save()
        } catch {
            NSLog("Error creating user: \(error)")
            moc.reset()
        }
    }
    
}
