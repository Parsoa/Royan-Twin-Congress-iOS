//
//  Speaker.swift
//  TwinCongress
//
//  Created by Mohammad Amin Borghei on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import ObjectMapper
import RealmSwift

class Speaker: Object, Mappable {
    dynamic var id: Int = -1
    dynamic var name: String?
    dynamic var avatarURL: String?
    dynamic var country: String?
    dynamic var email: String?
    dynamic var venue: String?
    dynamic var topic: String?
    dynamic var affiliation: String?
    dynamic var abstract: Abstract?
    dynamic var tag: String?
    dynamic var isBookmarked: Bool = false
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        avatarURL <- map["avatar"]
        country <- map["country"]
        email <- map["email"]
        venue <- map["venue"]
        topic <- map["topic"]
        affiliation <- map["affiliation"]
        abstract <- map["aabstract"]
    }
    
    static func getTag(congress: Congress, speakerType: SpeakerType) -> String {
        return congress.name + "|||" + speakerType.name
    }
    
    static func getTagForAward(speakerType: SpeakerType) -> String {
        return "Award" + "%%%%%" + speakerType.name
    }
}
