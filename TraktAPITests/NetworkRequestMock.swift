//
//  NetworkRequestMock.swift
//  TraktAPITests
//
//  Created by Edgar Cardoso on 07/08/18.
//  Copyright © 2018 Edgar Cardoso. All rights reserved.
//

import Foundation
@testable import TraktAPI

class NetworkRequestMock: NetworkRequestManager {
    var success = true
    
    func requestPopular(completion: @escaping ([JsonObject]?) -> Void) {
        if success {
            let json = Json(json: JsonHelper.readJson(name: "movies"))
            switch json {
            case .some(.array(let json)):
                completion(json)
            default:
                completion(nil)
            }
            return
        }
        
        completion(nil)
    }
    
    func request(with search: String, completion: @escaping ([JsonObject]?) -> Void) {
        if success {
            let json = Json(json: JsonHelper.readJson(name: "tron_search"))
            switch json {
            case .some(.array(let json)):
                completion(json)
            default:
                completion(nil)
            }
            return
        }
        
        completion(nil)
    }
    
    func requestImages(with id: Int, completion: @escaping ([JsonObject]?) -> Void) {
        if success {
            let json = Json(json: JsonHelper.readJson(name: "images"))
            switch json {
            case .some(.object(let json)):
                if let array = json["backdrops"] as? [JsonObject] {
                    completion(array)
                }
            default:
                completion(nil)
            }
            return
        }
        
        completion(nil)
    }
}
