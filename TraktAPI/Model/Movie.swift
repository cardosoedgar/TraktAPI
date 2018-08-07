//
//  Movie.swift
//  TraktAPI
//
//  Created by Edgar Cardoso on 05/08/18.
//  Copyright © 2018 Edgar Cardoso. All rights reserved.
//

import Foundation

class Movie {
    let title: String
    let year: Int
    let id: String
    let tagline: String
    let overview: String
    let released: String
    let runtime: Int
    let rating: Double
    let genres: [String]
    let tmdbId: Int
    var images: [String]?
    
    init?(jsonObject: JsonObject) {
        guard let title = jsonObject["title"] as? String,
            let year = jsonObject["year"] as? Int,
            let tagline = jsonObject["tagline"] as? String,
            let overview = jsonObject["overview"] as? String,
            let released = jsonObject["released"] as? String,
            let runtime = jsonObject["runtime"] as? Int,
            let rating = jsonObject["rating"] as? Double,
            let genres = jsonObject["genres"] as? [String],
            let ids = jsonObject["ids"] as? JsonObject,
            let id = ids["imdb"] as? String,
            let tmdbId = ids["tmdb"] as? Int else {
                return nil
        }
        
        self.title = title
        self.year = year
        self.id = id
        self.tagline = tagline
        self.overview = overview
        self.released = released
        self.runtime = runtime
        self.rating = rating
        self.genres = genres
        self.tmdbId = tmdbId
    }
}
