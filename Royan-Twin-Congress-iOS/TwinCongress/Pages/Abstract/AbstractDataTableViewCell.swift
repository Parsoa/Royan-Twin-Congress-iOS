//
//  AbstractDataTableViewCell.swift
//  TwinCongress
//
//  Created by Mohammad Amin Borghei on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit

class AbstractDataTableViewCell: UITableViewCell, Configurable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    func config(withItem item: Any) {
        let abstractData = item as! AbstractData
        titleLabel.config(text: abstractData.title, size: 17, textBold: true)
        valueLabel.config(text: abstractData.text, size: 17, alignment: .justified, textColorIn: UIColor.darkGray)
        iconImageView.image = abstractData.icon
    }
}
