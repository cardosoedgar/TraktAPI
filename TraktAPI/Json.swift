//
//  Json.swift
//  TraktAPI
//
//  Created by Edgar Cardoso on 02/08/18.
//  Copyright © 2018 Edgar Cardoso. All rights reserved.
//

import Foundation

typealias JsonObject = [String: Any]

enum Json {
    case object(_: JsonObject)
    case array(_: [JsonObject])
    
    init?(json: Any) {
        if let object = json as? JsonObject {
            self = .object(object)
            return
        }
        
        if let array = json as? [JsonObject] {
            self = .array(array)
            return
        }
        
        return nil
    }
}
