//
//  AgendaViewController.swift
//  TwinCongress
//
//  Created by Mohammad Amin Borghei on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit

class AgendaViewController: UITableViewController {
    
    let halls: [Hall]
    let cellIdentifier = String(describing: TitleImageTableViewCell.self)
    
    init() {
        halls =
            [
                Hall(name: "Main Hall (Hafez Hall)", icon: #imageLiteral(resourceName: "hafez_hall"), query: "Hafez"),
                Hall(name: "Rudaki Hall", icon: #imageLiteral(resourceName: "rudaki_hall"), query: "Rudaki"),
                Hall(name: "Saadi Hall", icon: #imageLiteral(resourceName: "saadi_hall"), query: "Saadi")
        ]
        
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "Agenda", image: #imageLiteral(resourceName: "agenda"), tag: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        halls = []
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Agenda"
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.rowHeight = 86
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return halls.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TitleImageTableViewCell
        if indexPath.row < halls.count {
            cell.config(hall: halls[indexPath.row])
        } else {
            cell.config(name: "At a Glance", icon: #imageLiteral(resourceName: "agenda_pictures"))
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller: UIViewController
        
        if indexPath.row < halls.count {
            controller = AgendaItemsViewController(hall: halls[indexPath.row])
        } else {
            controller = AgendaPictuesViewController()
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
