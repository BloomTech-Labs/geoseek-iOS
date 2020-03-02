//
//  NetworkingController.swift
//  GeoSeek
//
//  Created by morse on 2/25/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation

enum FetchError: Error {
    case badData
    case badResponse
    case badEncode
    case otherError
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class NetworkController {
    
    static let shared = NetworkController()
    private let baseURL = "https://geoseek-be-stage.herokuapp.com/api/"
    //    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func fetchGems(completion: @escaping (Result<[Gem], FetchError>) -> Void) {
        let request = gemsURL(with: .get)
        
        fetch(from: request) { result in
            switch result {
            case .failure(let error):
                #warning("Deal with failure to receive data error")
                completion(.failure(.badData))
                print("NetworkController.fetchGems:", error)
            case .success(let data):
                let possibleGems: [GemRepresentation]? = self.decode(data: data)
                
                guard let gemRepresentations = possibleGems else {
                    #warning("Deal with possibleGems being nil")
                    completion(.failure(.badEncode))
                    return
                }
                let gems = gemRepresentations.compactMap { Gem(representation: $0) }
                completion(.success(gems))
                print(gems.count)
            }
        }
    }
    
    func createGem(from gem: Gem) {
        guard let gemData = encode(item: gem.gemRepresentation) else { return }
        
        var request = gemsURL(with: .post)
        request.httpBody = gemData
        
        fetch(from: request) { result in
            switch result {
            case .failure(let error):
                print("Error creating gem: \(error)")
            case .success(let data):
                let possibleGemRepresentation: GemRepresentation? = self.decode(data: data)
                
                guard let gemRepresentation = possibleGemRepresentation else {
                    #warning("Deal with possibleGemRepresentation being nil")
                    return
                }
                #warning("Deal with created gem here")
                let gem = Gem(representation: gemRepresentation)
                print("Success! Created gem: \(gem.title)")
            }
        }
    }
    
    func fetch(from request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("NetworkController.fetch Error: \(error)")
                completion(.failure(error))
                return
            }
            
            
            //            if let response = response as? HTTPURLResponse,
            //                response.statusCode != 200 {
            //                print("NetworkController.fetch Response != 200: \(response)")
            //                completion(.failure(FetchError.badResponse))
            //                return
            //            }
            
            guard let data = data else {
                print("NetworkController.fetch Data is wrong")
                completion(.failure(FetchError.badData))
                return
            }
            print(String(data: data, encoding: .utf8))
            completion(.success(data))
        }
        dataTask.resume()
    }
    
    func decode<T: Codable>(data: Data) -> T? {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decoded = try jsonDecoder.decode(T.self, from: data)
            return decoded
        } catch {
            #warning("Deal with decoding error here")
            print(error)
            return nil
        }
    }
    
    func encode<T: Codable>(item: T) -> Data? {
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
    
    func gemsURL(with method: HTTPMethod) -> URLRequest {
        let url = URL(string: baseURL)!
        let endpoint = url.appendingPathComponent("gems")
        var request = URLRequest(url: endpoint)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("NetworkController.gemsURL:", url)
        return request
    }
}
