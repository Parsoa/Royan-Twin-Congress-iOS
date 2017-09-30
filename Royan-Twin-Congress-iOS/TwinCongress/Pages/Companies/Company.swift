//
//  Company.swift
//  TwinCongress
//
//  Created by Mohammad Amin Borghei on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import ObjectMapper
import RealmSwift

class Company: Object, Mappable {
    dynamic var id: Int = -1
    dynamic var name: String?
    dynamic var url: String?
    dynamic var phone: String?
    dynamic var address: String?
    dynamic var imageURL: String?
    dynamic var isSponser: Bool = false
    
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        url <- map["website"]
        phone <- map["phone"]
        address <- map["address"]
        imageURL <- map["logo"]
    }
}
