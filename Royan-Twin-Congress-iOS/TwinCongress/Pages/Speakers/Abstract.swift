//
//  Abstract.swift
//  TwinCongress
//
//  Created by Kianoosh Abbasi on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import ObjectMapper
import RealmSwift

class Abstract: Object, Mappable {
    dynamic var background: String?
    dynamic var objective: String?
    dynamic var method: String?
    dynamic var result: String?
    dynamic var conclusion: String?
    dynamic var keyword: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        background <- map["background"]
        objective <- map["objective"]
        method <- map["method"]
        result <- map["result"]
        conclusion <- map["conclusion"]
        keyword <- map["keyword"]
    }
}
