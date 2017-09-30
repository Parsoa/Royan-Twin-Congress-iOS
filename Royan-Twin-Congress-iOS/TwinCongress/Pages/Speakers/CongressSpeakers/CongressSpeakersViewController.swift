//
//  SpeakersViewController.swift
//  TwinCongress
//
//  Created by Kianoosh Abbasi on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class CongressSpeakersViewController: SpeakersViewController {
    
    let congress: Congress
    let speakerType: SpeakerType

    init(congress: Congress, speakerType: SpeakerType) {
        self.congress = congress
        self.speakerType = speakerType
        
        super.init(tag: Speaker.getTag(congress: self.congress, speakerType: speakerType))
        self.tabBarItem = UITabBarItem(title: speakerType.name, image: speakerType.icon, tag: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.congress = Congress()
        self.speakerType = SpeakerType(name: "", icon: #imageLiteral(resourceName: "DefaultPicture"), urlSuffix: "")
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = congress.name
    }

    override func getURLSuffix() -> String {
        return "\(congress.id)/\(speakerType.urlSuffix)/"
    }
}
