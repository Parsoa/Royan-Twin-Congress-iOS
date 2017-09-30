//
//  TableViewController.swift
//  TwinCongress
//
//  Created by Mohammad Amin Borghei on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//  Source: http://swiftandpainless.com/the-best-table-view-controller-mar-2016-edition/
//

import UIKit
import RealmSwift

class TableViewController<T, Cell: UITableViewCell>: UITableViewController where Cell: Configurable {
    
    private let cellIdentifier = String(describing: Cell.self)
    
    var data = [T]() {
        didSet {
            tableView.reloadData()
            if tableView.numberOfRows(inSection: 0) > 0 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    init() { super.init(nibName: nil, bundle: nil) }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        refreshControl = UIRefreshControl()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath) as! Cell
        cell.config(withItem: data[indexPath.row])
        return cell
    }
    
}

extension TableViewController where T: Object {
    func query() -> Results<T> {
        return realm.objects(T.self)
    }
    
    func removeAll() {
        try! realm.write {
            realm.delete(query())
        }
    }

    func addAll() {
        try! realm.write {
            realm.add(self.data)
        }
    }
    
    func fetchQuery() -> [T] {
        return Array(query())
    }
}
