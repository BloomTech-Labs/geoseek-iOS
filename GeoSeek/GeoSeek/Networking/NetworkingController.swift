//
//  NetworkingController.swift
//  GeoSeek
//
//  Created by morse on 2/25/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation

enum FetchError: String, Error {
    case badData = "There was a data error. Please try again." // TODO Fix error messages
    case badResponse = "There was a bad response. Please try again."
    case badEncode = "There was a problem encoding. Please try again."
    case otherError = "Something went wrong. Please try again."
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class NetworkController {
    
    // MARK: - Properties
    
    static let shared = NetworkController()
    private let baseURL = "https://geoseek-be-stage.herokuapp.com/api/"
    
    // MARK: - Lifecycle Methods
    
    private init() {}
    
    // MARK: - Gems
    
    func fetchGems(completion: @escaping (Result<[Gem], FetchError>) -> Void) {
        let request = gemsURL(with: .get)
        
        fetch(from: request) { result in
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
        
        fetch(from: request) { result in
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
//                print("Success! Created gem: \(gem.title ?? "No Title")") // This can go away after testing.
            }
        }
    }
    
    // MARK: - Users
    
    func signUp() {}
    
    // MARK: - Helper Methods
    
    private func fetch(from request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
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
//            print(String(data: data, encoding: .utf8))
            completion(.success(data))
        }
        dataTask.resume()
    }
    
    private func decode<T: Codable>(data: Data) -> T? {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decoded = try jsonDecoder.decode(T.self, from: data)
            return decoded
        } catch {
            print("Error decoding item from data: \(error)")
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
    
    // MARK: - URLs
    
    private func gemsURL(with method: HTTPMethod) -> URLRequest {
        let url = URL(string: baseURL)!
        let endpoint = url.appendingPathComponent("gems")
        var request = URLRequest(url: endpoint)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("NetworkController.gemsURL:", url)
        return request
    }
}
