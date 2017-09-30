//
//  SpeakerType.swift
//  TwinCongress
//
//  Created by Kianoosh Abbasi on 8/25/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit

class SpeakerType {
    let name: String
    let icon: UIImage
    let urlSuffix: String
    
    init(name: String, icon: UIImage, urlSuffix: String) {
        self.name = name
        self.icon = icon
        self.urlSuffix = urlSuffix
    }
}
