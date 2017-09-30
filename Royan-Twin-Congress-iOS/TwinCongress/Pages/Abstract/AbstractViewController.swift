//
//  CongressViewController.swift
//  TwinCongress
//
//  Created by Kianoosh Abbasi on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit

class AbstractViewController: TableViewController<AbstractData, AbstractDataTableViewCell> {
    
    var speaker: Speaker
    init(speaker: Speaker, data: [AbstractData]) {
        self.speaker = speaker
        super.init()
        self.data = data
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.speaker = Speaker()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = speaker.name
        tableView.allowsSelection = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(toggleBookmark))
        setBookmarkButtonImage()
        refreshControl = nil
    }
    
    func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func toggleBookmark() {
        try! realm.write {
            speaker.isBookmarked = !speaker.isBookmarked
            setBookmarkButtonImage()
        }
    }
    
    func setBookmarkButtonImage() {
        if speaker.isBookmarked {
            self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "bookmark_fill")
        } else {
            self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "bookmark")
        }
    }
}
