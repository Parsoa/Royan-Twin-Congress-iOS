//
//  BookmarksViewController.swift
//  TwinCongress
//
//  Created by Mohammad Amin Borghei on 8/26/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit
import RealmSwift

class BookmarksViewController: SpeakersViewController {

    init() {
        super.init(tag: "")
        tabBarItem = UITabBarItem(title: "Bookmarks", image: #imageLiteral(resourceName: "bookmark_fill"), tag: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = nil
        navigationItem.title = "Bookmarks"
        self.navigationItem.leftBarButtonItem = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchBar.text = ""
        self.speakers = Array(self.speakersQuery())
        self.data = self.speakers
    }
    
    override func fetchData() {
        // Do nothing
    }
    
    override func speakersQuery() -> Results<Speaker> {
        return realm.objects(Speaker.self).filter("isBookmarked == true")
    }

}
