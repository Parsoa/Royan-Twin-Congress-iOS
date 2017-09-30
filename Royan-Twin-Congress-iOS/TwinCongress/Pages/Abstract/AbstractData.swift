//
//  AbstractData.swift
//  TwinCongress
//
//  Created by Mohammad Amin Borghei on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit

class AbstractData {
    var title: String
    var text: String?
    var icon: UIImage
    
    init(title: String, text: String?, icon: UIImage) {
        self.title = title
        self.text = text
        self.icon = icon
    }
}
