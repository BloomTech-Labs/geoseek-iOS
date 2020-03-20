//
//  NetworkingController.swift
//  GeoSeek
//
//  Created by morse on 2/25/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation
import CoreData

enum FetchError: String, Error {
    case badData = "There was a data error. Please try again." // TODO Fix error messages
    case badResponse = "There was a bad response. Please try again."
    case badEncode = "There was a problem encoding. Please try again."
    case otherError = "Something went wrong. Please try again."
    case noUser = "Please log in."
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum UserAction: String {
    case login = "login"
    case register = "register"
}

class NetworkController {
    
    // MARK: - Properties
    
    static let shared = NetworkController()
    //    private let baseURL = URL(string: "https://geoseek-be-stage.herokuapp.com/api/")!
    //    private let baseURL = URL(string: "https://geoseek-be.herokuapp.com/api/")!
    private let baseURL = URL(string: "https://labs21-geoseek-be.herokuapp.com/api")!
    
    // MARK: - Lifecycle Methods
    
    private init() {}
    
    // MARK: - Gems
    
    func fetchGems(completion: @escaping (Result<[Gem], FetchError>) -> Void) {
        let request = gemsURL(with: .get)
//        let request = URLRequest.gsGemURL(from: baseURL, with: .get)
        
        perform(request) { result in
            switch result {
            case .failure(let error):
                completion(.failure(.badData))
                print("NetworkController.fetchGems:", error)
            case .success(let data):
                let possibleGems: [GemRepresentation]? = self.decode(data: data)
                
                guard let gemRepresentations = possibleGems else {
                    completion(.failure(.badEncode))
                    return
                }
                let gems = gemRepresentations.compactMap { Gem(representation: $0) }
                completion(.success(gems))
                print(gems.count)
            }
        }
    }
    
    func createGem(from gemRepresentation: GemRepresentation, completion: @escaping (Result<Gem, Error>) -> Void) {
        guard let gemData = encode(item: gemRepresentation) else { return }
        var request = gemsURL(with: .post)
        request.httpBody = gemData
        
        perform(request) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                let possibleReturnedGem: ReturnedGem? = self.decode(data: data)
                guard let returnedGem = possibleReturnedGem,
                    let returnedID = returnedGem.gem.first else {
                        completion(.failure(FetchError.badData))
                        return
                }
                var completeGemRepresentation = gemRepresentation
                completeGemRepresentation.id = returnedID
                let gem = Gem(representation: completeGemRepresentation)
                completion(.success(gem))
            }
        }
    }
    
    // MARK: - Users
    
    //        let user = "user123" // also user223, user323, user423, user001, user002, user003, user004, user005, user006
    //        let password = "aGoodPassword2"
    //        let email = "email@email.com"
    
    func register(with username: String, password: String, email: String, completion: @escaping (Result<User, Error>) -> Void) {
        removeUser()
        let userToRegister = createUserJSON(username, password, and: email)
        var request = usersURL(with: .post, and: .register)
        request.httpBody = userToRegister

        perform(request) { result in
            switch result {
            case .failure(let error):
                print("Register error: \(error)")
                completion(.failure(FetchError.otherError))
            case .success(let data):
                let possibleIdHolder: [ReturnedRegister]? = self.decode(data: data)
                if let idHolder = possibleIdHolder?.first {
                    let user = User(email: email, id: idHolder.id, password: password, username: username, context: .context)
                    do {
                        // Does this need to go on a background context? If so, the above does too.
                        try CoreDataStack.shared.mainContext.save()
                        completion(.success(user))
                    } catch {
                        print("User was registered, but the user data was not saved to CoreData: \(error)")
                    }
                }
            }
        }
    }
    
    func signIn(with username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        removeUser()
        let user = createUserJSON(username, password, and: "")
        var request = usersURL(with: .post, and: .login)
        request.httpBody = user

        perform(request) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                let returnedUser: ReturnedUser? = self.decode(data: data)
                guard let id = returnedUser?.userId,
                    let email = returnedUser?.email,
                    let token = returnedUser?.token else {
                        completion(.failure(FetchError.badData))
                        return
                }
                User(email: email, id: id, password: password, username: username, token: token, context: .context)
                do {
                    try CoreDataStack.shared.mainContext.save()
                    completion(.success("Yay!"))
                } catch {
                    completion(.failure(FetchError.otherError))
                }
            }
        }
    }
    
    private func createUserJSON(_ username: String, _ password: String, and email: String) -> Data? {
        var json = ""
        if email.isEmpty {
            json = """
            {
            "username": "\(username)",
            "password": "\(password)"
            }
            """
        } else {
            json = """
            {
            "username": "\(username)",
            "password": "\(password)",
            "email": "\(email)"
            }
            """
        }
        
        let jsonData = json.data(using: .utf8)
        guard let unwrapped = jsonData else {
            print("No data!")
            return nil
        }
        return unwrapped
    }
    
    // MARK: - Completed Routes
    // Can't be tested yet.
    func markGemCompleted(_ gem: Gem, comments: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let user = retrieveUser() else {
            completion(.failure(FetchError.noUser))
            return
        }
        let completedToSend = CompletedToSend(gemId: Int(gem.id), completedBy: Int(user.id), comments: comments)
        var request = completedURL(with: .post, and: user)
        let encodedCompletedBy = encode(item: completedToSend)
        request.httpBody = encodedCompletedBy

        perform(request) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
                return
            case .success(let data):
                guard let _: ReceivedCompleted = self.decode(data: data) else {
                    completion(.failure(FetchError.otherError))
                    return
                }
                completion(.success("Completed!"))
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func perform(_ request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("NetworkController.fetch Error: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("NetworkController.fetch Data is wrong")
                completion(.failure(FetchError.badData))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            completion(.success(data))
        }
        dataTask.resume()
    }
    
    private func decode<T: Codable>(data: Data) -> T? {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .iso8601
        do {
            let decoded = try jsonDecoder.decode(T.self, from: data)
            return decoded
        } catch {
            print("Error decoding item from data: \(error)")
            print(String(data: data, encoding: .utf8)!)
            return nil
        }
    }
    
    private func encode<T: Codable>(item: T) -> Data? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        do{
            let encoded = try jsonEncoder.encode(item)
            return encoded
        } catch {
            print("Error encoding item from data: \(error)")
            return nil
        }
    }
    
    private func removeUser() {
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
    
    private func retrieveUser() -> User? {
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
    
    // MARK: - URLs
    
    private func gemsURL(with method: HTTPMethod) -> URLRequest {
        let endpoint = baseURL.appendingPathComponent("gems")
        var request = URLRequest(url: endpoint)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func usersURL(with method: HTTPMethod, and userAction: UserAction, for user: User? = nil) -> URLRequest {
        var url = baseURL
            .appendingPathComponent("users")
            .appendingPathComponent(userAction.rawValue)
        if let user = user {
            url = url.appendingPathComponent("\(user.id)")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func completedURL(with method: HTTPMethod, and user: User) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("completed")
            .appendingPathComponent("\(user.id)")
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}

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
}

extension URLRequest {
    static func gsGemURL(from url: URL, with method: HTTPMethod) -> URLRequest {
        let endpoint = url.appendingPathComponent("gems")
        var request = URLRequest(url: endpoint)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    static func gsUserURL(from url: URL, with method: HTTPMethod, and userAction: UserAction, for user: User? = nil) -> URLRequest {
        var url = url
            .appendingPathComponent("users")
            .appendingPathComponent(userAction.rawValue)
        if let user = user {
            url = url.appendingPathComponent("\(user.id)")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    static func gsCompletedURL(from url: URL, with method: HTTPMethod, and user: User) -> URLRequest {
        let url = url
            .appendingPathComponent("completed")
            .appendingPathComponent("\(user.id)")
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}

let thing = """
{
    "gem_id": 2,
    "completed_by": 2,
    "comments": "test2"
}
this one is what will be returned:
{
  "id": 6,
  "gem_id": 2,
  "completed_at": "2020-03-11T22:48:44.197Z",
  "completed_by": 2,
  "comments": "test2"
}
"""
