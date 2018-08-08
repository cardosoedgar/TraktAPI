//
//  MovieManager.swift
//  TraktAPI
//
//  Created by Edgar Cardoso on 05/08/18.
//  Copyright © 2018 Edgar Cardoso. All rights reserved.
//

import Foundation

class MovieManager {
    private let network = NetworkRequest()
    private var movies = [Movie]()
    
    func requestPopularMovies(completion: @escaping (Bool) -> Void) {
        network.requestPopular { result in
            guard let result = result else {
                completion(false)
                return
            }
            
            self.movies = result.compactMap { return Movie(jsonObject: $0) }
            completion(true)
        }
    }
    
    func requestMovie(with string: String, completion: @escaping (Bool) -> Void) {
        network.request(with: string) { result in
            guard let result = result else {
                completion(false)
                return
            }
            
            self.movies = result.compactMap {
                if let json = $0["movie"] as? JsonObject {
                    return Movie(jsonObject: json)
                }
                return nil
            }
            completion(true)
        }
    }
    
    func requestImages(with id: Int, completion: @escaping ([String]?) -> Void) {
        network.requestImages(with: id) { images in
            completion(images?.compactMap { $0["file_path"] as? String })
        }
    }
    
    func getMovies() -> [Movie] {
        return movies
    }
    
    func getMovie(at index: Int) -> Movie? {
        if index > movies.count || index < 0 {
            return nil
        }
        
        return movies[index]
    }
    
    func getMoviesCount() -> Int {
        return movies.count
    }
}
