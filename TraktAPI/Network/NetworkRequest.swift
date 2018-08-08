//
//  NetworkRequest.swift
//  TraktAPI
//
//  Created by Edgar Cardoso on 02/08/18.
//  Copyright © 2018 Edgar Cardoso. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error
}

class NetworkRequest {
    init() {
        
    }
    
    func requestPopular(completion: @escaping ([JsonObject]?) -> Void) {
        let stringUrl = "https://api.trakt.tv/movies/popular?limit=50&extended=full"
        guard let urlRequest = createURLRequest(with: stringUrl) else {
            return
        }
        
        request(with: urlRequest) { result in
            switch result {
            case .success(.array(let json)):
                completion(json)
            default:
                completion(nil)
            }
        }
    }
    
    func request(with search: String, completion: @escaping ([JsonObject]?) -> Void) {
        let stringUrl = "https://api.trakt.tv/search/movie?query=\(search)&extended=full&limit=50"
        guard let urlRequest = createURLRequest(with: stringUrl) else {
            return
        }
        
        request(with: urlRequest) { result in
            switch result {
            case .success(.array(let json)):
                completion(json)
            default:
                completion(nil)
            }
        }
    }
    
    func requestImages(with id: Int, completion: @escaping ([JsonObject]?) -> Void) {
        let stringUrl = "https://api.themoviedb.org/3/movie/\(id)/images?api_key=7136413a68639a72d950593f82f73a0d"
        guard let urlRequest = createURLRequest(with: stringUrl) else {
            return
        }
        
        request(with: urlRequest) { result in
            switch result {
            case .success(.object(let json)):
                if let array = json["backdrops"] as? [JsonObject] {
                    completion(array)
                } else {
                    completion(nil)
                }
            default:
                completion(nil)
            }
        }
    }
    
    private func request(with request: URLRequest, completion: @escaping (Result<Json>) -> Void) {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { data, url, error in
            if let data = data {
                let validJson = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let validJson = validJson, let json = Json(json: validJson) {
                    DispatchQueue.main.async {
                        completion(.success(json))
                    }
                    return
                }
            }
            
            DispatchQueue.main.async {
                completion(.error)
            }
        }
        
        task.resume()
    }
    
    private func createURLRequest(with string: String) -> URLRequest? {
        guard let url = URL(string: string) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.addValue("2", forHTTPHeaderField: "trakt-api-version")
        request.addValue("193da40a59113f56cb3f51a35303efd6299dcb65c800fdcdfac5b951f098acf8",
                         forHTTPHeaderField: "trakt-api-key")
        return request
    }
}
