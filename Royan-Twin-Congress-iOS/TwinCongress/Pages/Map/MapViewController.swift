//
//  MapViewController.swift
//  TwinCongress
//
//  Created by Kianoosh Abbasi on 8/27/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit

class MapViewController: ImagesViewController {

    init() {
        let images = [#imageLiteral(resourceName: "grand_floor"), #imageLiteral(resourceName: "floor_minus_one"), #imageLiteral(resourceName: "floor_minus_two")]
        let titles = ["Grand Floor", "Floor -1", "Floor -2"]
        super.init(images: images, titles: titles)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Map"
    }
    
}
