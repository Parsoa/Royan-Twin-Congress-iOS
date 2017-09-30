//
//  SpeakerTableViewCell.swift
//  TwinCongress
//
//  Created by Mohammad Amin Borghei on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit

class SpeakerTableViewCell: UITableViewCell, Configurable, UIWebViewDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    
    @IBOutlet weak var nameImageView: UIImageView!
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var venueImageView: UIImageView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var affiliationLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    
    var id: Int!
    
    override func awakeFromNib() {
        nameImageView.image = #imageLiteral(resourceName: "name")
        emailImageView.image = #imageLiteral(resourceName: "email")
        countryImageView.image = #imageLiteral(resourceName: "country")
        venueImageView.image = #imageLiteral(resourceName: "venue")
        self.avatarImageView.circle()
    }

    func config(withItem item: Any) {
        let speaker = item as! Speaker
        self.id = speaker.id
        
        nameLabel.config(text: speaker.name, size: 17, textBold: true)
        emailLabel.config(text: speaker.email, size: 14)
        countryLabel.config(text: speaker.country, size: 14)
        venueLabel.config(text: speaker.venue, size: 14)
        affiliationLabel.config(text: speaker.affiliation, size: 14, alignment: .justified, textColorIn: UIColor.darkGray)
        topicLabel.config(text: speaker.topic, size: 14, alignment: .justified, textColorIn: UIColor.darkGray)
        avatarImageView.image = #imageLiteral(resourceName: "DefaultPicture")
        
        ImageStore.download(url: speaker.avatarURL) { image, success in
            if success && self.id == speaker.id {
                self.avatarImageView.image = image
            }
        }
    }
    
}
