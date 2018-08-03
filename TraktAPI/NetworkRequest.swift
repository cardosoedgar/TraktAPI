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
    
    func request(with search: String, completion: @escaping (Result<Json>) -> Void) {
        guard let request = createURLRequest(with: search) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, url, error in
            guard let data = data else {
                return
            }
            
            let validJson = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            if let validJson = validJson, let json = Json(json: validJson) {
                completion(.success(json))
                return
            }
            
            completion(.error)
        }
        
        task.resume()
    }
    
    private func createURLRequest(with search: String) -> URLRequest? {
        guard let url = URL(string: "https://api.trakt.tv/search/movie?query=\(search)") else {
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
