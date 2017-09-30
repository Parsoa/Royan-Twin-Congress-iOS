//
//  AgendaItemTableViewCell.swift
//  TwinCongress
//
//  Created by Kianoosh Abbasi on 8/25/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit

class AgendaItemTableViewCell: UITableViewCell, Configurable {

    @IBOutlet weak var verticalLine: UIView!

    @IBOutlet weak var timeBackgroundView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nameIcon: UIImageView!
    @IBOutlet weak var topicIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        verticalLine.backgroundColor = Color.theme
        timeBackgroundView.backgroundColor = UIColor.lightGray
        timeBackgroundView.layer.cornerRadius = timeBackgroundView.frame.height / 2
        timeBackgroundView.clipsToBounds = true
        
        nameIcon.image = #imageLiteral(resourceName: "name")
        topicIcon.image = #imageLiteral(resourceName: "topic")
    }

    func config(withItem item: Any) {
        let item = item as! AgendaItem
        nameLabel.config(text: item.name, size: 15, textBold: true)
        timeLabel.config(text: item.time, size: 14)
        topicLabel.config(text: item.topic, size: 14, textColorIn: UIColor.darkGray)
    }
}
