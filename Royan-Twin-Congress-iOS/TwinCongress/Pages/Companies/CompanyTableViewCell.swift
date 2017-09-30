//
//  CompanyTableViewCell.swift
//  TwinCongress
//
//  Created by Mohammad Amin Borghei on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell, Configurable, UIWebViewDelegate {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var id: Int!
    var webView: UIWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.logoImageView.circle()
        self.urlLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(urlTapped)))
        self.urlLabel.isUserInteractionEnabled = true
    }
    
    func urlTapped() {
        UIApplication.shared.open(URL(string: urlLabel.text ?? "http://www.royaninstitute.org")!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(withItem item: Any) {
        let company = item as! Company
        self.id = company.id ?? -1
        nameLabel.config(text: company.name, size: 16, numberOfLines: 1, textBold: true)
        urlLabel.config(text: company.url, size: 16, numberOfLines: 1, textColorIn: UIColor.blue)
        phoneLabel.config(text: company.phone, size: 16, numberOfLines: 1)
        addressLabel.config(text: company.address, size: 14, textColorIn: UIColor.darkGray)
        
        logoImageView.image = #imageLiteral(resourceName: "DefaultPicture")
        ImageStore.download(url: company.imageURL) { image, success in
            if success && self.id == company.id {
                self.logoImageView.image = image
            }
        }
    }
    
}
