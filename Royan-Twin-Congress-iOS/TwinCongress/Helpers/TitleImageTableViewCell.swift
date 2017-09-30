//
//  TitleImageTableViewCell
//  TwinCongress
//
//  Created by Mohammad Amin Borghei on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit

class TitleImageTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    func config(hall: Hall) {
        nameLabel.config(text: hall.name, size: 16, textBold: true)
        iconImageView.image = hall.icon
    }
    
    func config(congress: Congress) {
        nameLabel.config(text: congress.name, size: 16, textBold: true)
        iconImageView.image = congress.icon
    }

    func config(name: String, icon: UIImage) {
        nameLabel.config(text: name, size: 16, textBold: true)
        iconImageView.image = icon
    }
    
}
