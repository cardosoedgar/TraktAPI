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
    
    init?(jsonObject: JsonObject) {
        guard let title = jsonObject["title"] as? String,
            let year = jsonObject["year"] as? Int,
            let ids = jsonObject["ids"] as? JsonObject,
            let id = ids["imdb"] as? String else {
                return nil
        }
        
        self.title = title
        self.year = year
        self.id = id
    }
}
