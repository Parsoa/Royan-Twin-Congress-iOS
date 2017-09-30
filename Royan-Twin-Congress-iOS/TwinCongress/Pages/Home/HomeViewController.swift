//
//  HomeViewController.swift
//  TwinCongress
//
//  Created by Kianoosh Abbasi on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    let congressSpeakerTypes: [SpeakerType]
    let awardSpeakerTypes: [SpeakerType]
    
    let congresses: [Congress]
    let cellIdentifier = String(describing: TitleImageTableViewCell.self)
    
    init() {
        congressSpeakerTypes =
            [
                SpeakerType(name: "Invited Speakers", icon: #imageLiteral(resourceName: "invited_speakers"), urlSuffix: "all_is_speaker"),
                SpeakerType(name: "Oral Speakers", icon: #imageLiteral(resourceName: "oral_speakers"), urlSuffix: "all_op_speaker"),
                SpeakerType(name: "Poster Presentation", icon: #imageLiteral(resourceName: "poster_speakers"), urlSuffix: "all_poster_speaker")
        ]

        awardSpeakerTypes =
            [
                SpeakerType(name: "International Winners", icon: #imageLiteral(resourceName: "international_winners"), urlSuffix: "all_international_winners"),
                SpeakerType(name: "National Winners", icon: #imageLiteral(resourceName: "national_winners"), urlSuffix: "all_national_winners"),
        ]
        
        let scc = Congress(id: "scc", name: "Stem Cell Congress", icon: #imageLiteral(resourceName: "stem_cell"))
        let rbc = Congress(id: "rbc", name: "Reproductive Biomedicine Congress", icon: #imageLiteral(resourceName: "reprodutive"))
        let nc = Congress(id: "nc", name: "Nurse Congress", icon: #imageLiteral(resourceName: "nurse"))
        congresses = [scc, rbc, nc]
        
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), tag: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        congressSpeakerTypes = []
        awardSpeakerTypes = []
        congresses = []
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Royan Twin Congress"
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.rowHeight = 86
        
        let bannerImageView = UIImageView(image: #imageLiteral(resourceName: "Banner"))
        view.addSubview(bannerImageView)
        
        bannerImageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        bannerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bannerImageView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return congresses.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TitleImageTableViewCell
        if indexPath.row < congresses.count {
            cell.config(congress: congresses[indexPath.row])
        } else {
            cell.config(name: "Awards", icon: #imageLiteral(resourceName: "award"))
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = UITabBarController()
        var viewControllers = [UIViewController]()
        
        if indexPath.row < congresses.count {
            let congress = congresses[indexPath.row]
            
            for speakerType in congressSpeakerTypes {
                viewControllers.append(UINavigationController(rootViewController:CongressSpeakersViewController(congress: congress, speakerType: speakerType)))
            }
        } else {
            
            for speakerType in awardSpeakerTypes {
                viewControllers.append(UINavigationController(rootViewController:AwardsViewController(speakerType: speakerType)))
            }

        }
        

        controller.viewControllers = viewControllers
        present(controller, animated: true, completion: nil)
    }

}
