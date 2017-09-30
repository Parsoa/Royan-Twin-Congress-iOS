//
//  AgendaItem.swift
//  TwinCongress
//
//  Created by Kianoosh Abbasi on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import ObjectMapper
import RealmSwift

class AgendaItem: Object, Mappable {
    dynamic var id: Int = -1
    dynamic var name: String?
    dynamic var topic: String?
    dynamic var time: String?
    dynamic var venue: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        topic <- map["topic"]
        time <- map["time"]
        venue <- map["venue"]
    }
}
