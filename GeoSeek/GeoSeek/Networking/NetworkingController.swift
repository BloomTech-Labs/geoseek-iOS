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
    case otherError
}

class NetworkController {
    
    static let shared = NetworkController()
    private let baseURL = "https://geoseek-be-stage.herokuapp.com/api/"
    //    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func fetchGems(completion: @escaping (Result<[Gem], FetchError>) -> Void) {
        let request = gemsURL()
        fetch(from: request) { result in
            switch result {
            case .failure(let error):
                #warning("Deal with failure to receive data error")
                print("NetworkController.fetchGems:", error)
            case .success(let data):
                let possibleGems: [GemRepresentation]? = self.decode(data: data)
                guard let gemRepresentations = possibleGems else {
                    #warning("Deal with possibleThing being nil")
                    return
                }
                let gems = gemRepresentations.compactMap { Gem(representation: $0) }
                completion(.success(gems))
                print(gems.count)
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
    
    func gemsURL() -> URLRequest {
        let url = URL(string: baseURL)!
        let endpoint = url.appendingPathComponent("gems")
        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("NetworkController.gemsURL:", url)
        return request
    }
}

// func createGem(from gem: Gem) {
//        let endpoint = baseURL + "gems"
//        
//        guard let url = URL(string: endpoint) else {
////            completion(.failure(.urlError))
//            return
//        }
//        print("URL:", url)
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        var jsonData: Data
//        let encoder = JSONEncoder()
//        do {
//            jsonData = try encoder.encode()
//        } catch {
//            return
//        }
//        request.httpBody = jsonData
//        print(String(data: jsonData, encoding: .utf8))
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            
//            if let error = error {
////                completion(.failure(.error))
//                print("HERE!:", error)
//                return
//            }
//            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8))
//            
//            //            guard let response = response as? HTTPURLResponse,
//            //                response.statusCode == 200 else {
//            //                    print("HERE!:")
//            //                    completion(.failure(.error))
//            //                    return
//            //            }
//            
////            guard let data = data else {
//////                completion(.failure(.error))
////                return
////            }
////
////            do {
////                let decoder = JSONDecoder()
////                decoder.keyDecodingStrategy = .convertFromSnakeCase
////                let gems = try decoder.decode([Gem].self, from: data)
////
//////                completion(.success("It worked!"))
////            } catch {
////                print(error)
//////                completion(.failure(.error))
////            }
//        }
//        task.resume()
//    }
