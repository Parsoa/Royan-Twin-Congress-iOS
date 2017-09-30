//
//  TableViewController.swift
//  TwinCongress
//
//  Created by Mohammad Amin Borghei on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class CompaniesViewController: TableViewController<Company, CompanyTableViewCell> {

    struct Segment {
        static let companies = 0
        static let sponsers = 1
        
        static var count: Int {
            return 2
        }
    }
    
    var companies: [Company] = []
    var sponsers: [Company] = []
    var segmentedControl: UISegmentedControl!
    
    override init() {
        super.init()
        tabBarItem = UITabBarItem(title: "Companies", image: #imageLiteral(resourceName: "companies"), tag: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var items = [String](repeating: "", count: Segment.count)
        items[Segment.companies] = "Companies"
        items[Segment.sponsers] = "Sponsers"
        
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = Segment.companies
        segmentedControl.addTarget(self, action: #selector(showRelatedData), for: .valueChanged)
        navigationItem.titleView = segmentedControl
        if let navigationBar = navigationController?.navigationBar {
            segmentedControl.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: 8).isActive = true
            segmentedControl.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor).isActive = true
            segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        }
        refreshControl?.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        
        if query().count == 0 {
            fetchData()
        } else {
            self.sponsers = Array(realm.objects(Company.self).filter({ $0.isSponser == true }))
            self.companies = Array(realm.objects(Company.self).filter({ $0.isSponser == false }))
            showRelatedData()
        }
    }

    func showRelatedData() {
        switch segmentedControl.selectedSegmentIndex {
        case Segment.companies:
            self.data = companies
            tableView.allowsSelection = false
        case Segment.sponsers:
            self.data = sponsers
            tableView.allowsSelection = true
        default:
            break
        }
    }
    
    func fetchData() {
        refreshControl?.beginRefreshing()
        let group = DispatchGroup()
        
        group.enter()
        Alamofire.request(Url.base + "company/all_sp_company/").validate().responseArray {
            (response: DataResponse<[Company]>) in
            if response.result.isSuccess {
                self.sponsers = response.result.value ?? []
                _ = self.sponsers.map({ $0.isSponser = true })
            }
            group.leave()
        }

        group.enter()
        Alamofire.request(Url.base + "company/all_or_company/").validate().responseArray {
            (response: DataResponse<[Company]>) in
            if response.result.isSuccess {
                self.companies = response.result.value ?? []
                _ = self.companies.map({ $0.isSponser = false })
            }
            group.leave()
        }

        group.notify(queue: .main) {
            self.refreshControl?.endRefreshing()
            self.showRelatedData()
            if self.sponsers.count + self.companies.count > 0 {
                self.removeAll()
                try! realm.write {
                    realm.add(self.sponsers)
                    realm.add(self.companies)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sponser = sponsers[indexPath.row]
        if let image = UIImage(named: sponser.name?.lowercased() ?? "") {
        let imageViewController = ImageViewController(image: image, name: sponser.name ?? "")
            present(UINavigationController(rootViewController: imageViewController), animated: false) {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}
