//
//  SpeakersViewController.swift
//  TwinCongress
//
//  Created by Mohammad Amin Borghei on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class AwardsViewController: SpeakersViewController {
    
    let speakerType: SpeakerType
    
    init(speakerType: SpeakerType) {
        self.speakerType = speakerType
        super.init(tag: Speaker.getTagForAward(speakerType: speakerType))
        self.tabBarItem = UITabBarItem(title: speakerType.name, image: speakerType.icon, tag: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.speakerType = SpeakerType(name: "", icon: #imageLiteral(resourceName: "DefaultPicture"), urlSuffix: "")
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Awards"
    }

    override func getURLSuffix() -> String {
        return "akp/\(speakerType.urlSuffix)/"
    }
    
}
