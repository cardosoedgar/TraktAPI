//
//  JsonHelper.swift
//  TraktAPITests
//
//  Created by Edgar Cardoso on 07/08/18.
//  Copyright © 2018 Edgar Cardoso. All rights reserved.
//

import Foundation

class JsonHelper {
    class func readJson(name: String) -> Any {
        do {
            if let file = Bundle(for: self).url(forResource: name, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    return object
                } else if let object = json as? [Any] {
                    // json is an array
                    return object
                } else {
                    return ""
                }
            } else {
                return ""
            }
        } catch {
            return ""
        }
    }
}
