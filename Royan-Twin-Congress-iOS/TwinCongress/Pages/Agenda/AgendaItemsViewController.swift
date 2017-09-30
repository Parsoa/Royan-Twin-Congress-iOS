//
//  AgendaItemsTableViewController.swift
//  TwinCongress
//
//  Created by Kianoosh Abbasi on 8/25/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import RealmSwift

class AgendaItemsViewController: TableViewController<AgendaItem, AgendaItemTableViewCell> {
    
    let hall: Hall
    
    init(hall: Hall) {
        self.hall = hall
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.hall = Hall(name: "", icon: #imageLiteral(resourceName: "DefaultPicture"), query: "x")
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = hall.name
        refreshControl?.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        tableView.allowsSelection = false
        
        if itemsQuery().count == 0 {
            fetchData()
        } else {
            data = Array(itemsQuery())
        }
    }

    func fetchData() {
        refreshControl?.beginRefreshing()
        Alamofire.request(Url.base + "agenda/all_events/").responseArray { (response: DataResponse<[AgendaItem]>) in
            self.refreshControl?.endRefreshing()
            if let data = response.result.value {
                self.removeAll()
                try! realm.write {
                    realm.add(data)
                }
                self.data = Array(self.itemsQuery())
            }
        }
    }
    
    func itemsQuery() -> Results<AgendaItem> {
        return super.query().filter("venue contains %@", hall.query)
    }
    
}
