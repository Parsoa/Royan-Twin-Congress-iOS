//
//  IntroViewController.swift
//  TwinCongress
//
//  Created by Kianoosh Abbasi on 8/25/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit
import Alamofire

class IntroViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.hidesWhenStopped = true
        logoImageView.image = #imageLiteral(resourceName: "IconPicture")
        self.view.backgroundColor = Color.theme
        titleLabel.config(text: "Royan Congress", size: 22, textColorIn: UIColor.white, textBold: true)
        subtitleLabel.config(text: "Royan TuCAGene 2017", size: 11, textColorIn: UIColor.white)
        errorLabel.config(text: "Failed to connect to the server\n please tap to retry.", size: 14, alignment: .center, textColorIn: UIColor.darkGray)
        errorLabel.isHidden = true
        errorLabel.isUserInteractionEnabled = true
        errorLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(checkRemoteConnection)))
        checkRemoteConnection()
    }

    
    func checkRemoteConnection() {
        errorLabel.isHidden = true
        indicator.color = UIColor.white
        indicator.startAnimating()
        Alamofire.request(Url.base + "akp/all_national_winners/").validate().responseString { response in
            self.indicator.stopAnimating()
            if response.result.isSuccess {
                self.present(ActivationViewController(), animated: true, completion: nil)
            } else {
                self.errorLabel.isHidden = false
            }
        }
    }

}
