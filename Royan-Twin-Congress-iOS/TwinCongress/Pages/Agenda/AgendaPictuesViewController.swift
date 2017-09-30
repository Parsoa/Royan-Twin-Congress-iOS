//
//  AgendaPictuesViewController.swift
//  TwinCongress
//
//  Created by Mohammad Amin Borghei on 8/27/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit

class AgendaPictuesViewController: ImagesViewController {

    init() {
        let images = [#imageLiteral(resourceName: "agenda_picture_1")]
        let titles = [""]
        super.init(images: images, titles: titles)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "At a Glance"
    }

}
