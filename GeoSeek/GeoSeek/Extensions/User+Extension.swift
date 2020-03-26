//
//  User+Extension.swift
//  GeoSeek
//
//  Created by morse on 3/21/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation
import CoreData

extension User {
    static func retrieveUser() -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let context = CoreDataStack.shared.mainContext
        let possibleUsers = try? context.fetch(fetchRequest)
        if let users = possibleUsers {
            if let user = users.first {
                return user
            }
        }
        return nil
    }
    
    static func removeUser() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let context = CoreDataStack.shared.mainContext
        do {
            let profiles = try context.fetch(fetchRequest)
            for profile in profiles {
                context.delete(profile)
            }
            try CoreDataStack.shared.save(context: context)
        } catch {
            print("Could not log User(s) out")
        }
    }
    
    static func checkToken() {
        let twentyHours: Double = 60 * 60 * 20
        
        guard let user = User.retrieveUser(),
            let tokenTime = user.tokenTime else { return }
        
        if Date().timeIntervalSince(tokenTime) > twentyHours,
            let username = user.username,
            let password = user.password {
            NetworkController.shared.signIn(with: username, password: password) { result in
                switch result {
                case .failure(let error):
                    print("Error renewing token: \(error)")
                case .success(_):
                    print("Token was renewed!")
                }
            }
        }
    }
}
