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
