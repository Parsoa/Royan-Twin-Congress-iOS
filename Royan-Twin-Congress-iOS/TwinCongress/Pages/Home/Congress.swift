//
//  Models.swift
//  TwinCongress
//
//  Created by Kianoosh Abbasi on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit

class Congress {
    var id: String
    var name: String
    var icon: UIImage
    
    init() {
        id = ""
        name = ""
        icon = UIImage()
    }
    
    init(id: String, name: String, icon: UIImage) {
        self.id = id
        self.name = name
        self.icon = icon
    }
}
