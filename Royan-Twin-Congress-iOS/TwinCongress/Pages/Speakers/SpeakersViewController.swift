//
//  SpeakersViewController.swift
//  TwinCongress
//
//  Created by Mohammad Amin Borghei on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import RealmSwift

class SpeakersViewController: TableViewController<Speaker, SpeakerTableViewCell>, UISearchBarDelegate {
    
    var searchBar: UISearchBar!
    var speakers: [Speaker] = []
    let tag: String
    
    init(tag: String) {
        self.tag = tag
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.tag = "z"
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 20, height: 1))
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.tintColor = UIColor.black
        searchBar.placeholder = "Search speakers"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        
        refreshControl?.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        
        addDismissButton(action: #selector(backTapped))
        
        if speakersQuery().count == 0 {
            fetchData()
        } else {
            speakers = Array(speakersQuery())
            data = speakers
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.fullData().count != 0 {
            return 44
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.fullData().count != 0 {
            return searchBar
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let speaker = self.data[indexPath.row]
        
        var abstractData = [AbstractData]()
        let abstract = speaker.abstract
        
        if abstract?.background?.characters.count ?? 0  > 0 {
            abstractData.append(AbstractData(title: "Background", text: abstract?.background, icon: #imageLiteral(resourceName: "background")))
        }
        
        if abstract?.objective?.characters.count ?? 0  > 0 {
            abstractData.append(AbstractData(title: "Objectives", text: abstract?.objective, icon: #imageLiteral(resourceName: "objective")))
        }
        
        if abstract?.keyword?.characters.count ?? 0  > 0 {
            abstractData.append(AbstractData(title: "Keyword", text: abstract?.keyword, icon: #imageLiteral(resourceName: "keyword")))
        }
        
        if abstract?.method?.characters.count ?? 0  > 0 {
            abstractData.append(AbstractData(title: "Method", text: abstract?.method, icon: #imageLiteral(resourceName: "method")))
        }
        
        if abstract?.result?.characters.count ?? 0  > 0 {
            abstractData.append(AbstractData(title: "Result", text: abstract?.result, icon: #imageLiteral(resourceName: "result")))
        }
        
        if abstract?.conclusion?.characters.count ?? 0  > 0 {
            abstractData.append(AbstractData(title: "Conclusion", text: abstract?.conclusion, icon: #imageLiteral(resourceName: "conclusion")))
        }
        
        
        navigationController?.pushViewController(AbstractViewController(speaker: speaker, data: abstractData), animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableView.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.data = self.fullData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let text = searchBar.text?.lowercased() ?? ""
        self.data = self.fullData().filter { speaker in
            return speaker.name?.lowercased().contains(text) == true || speaker.topic?.lowercased().contains(text) == true || speaker.venue?.lowercased().contains(text) == true || speaker.email?.lowercased().contains(text) == true || speaker.country?.lowercased().contains(text) == true || speaker.affiliation?.lowercased().contains(text) == true
        }
    }
    
    func fullData() -> [Speaker] {
        return speakers
    }
    
    func fetchData() {
        refreshControl?.beginRefreshing()
        Alamofire.request(Url.base + getURLSuffix()).validate().responseArray { (response: DataResponse<[Speaker]>) in
            if response.result.isSuccess {
                self.speakers = response.result.value ?? []
                let bookmarkedSpeakers = self.speakersQuery().filter("isBookmarked == true")
                
                _ = self.speakers.map{ speaker in
                    speaker.tag = self.tag;
                    if speaker.id != -1 {
                        speaker.isBookmarked = bookmarkedSpeakers.contains(where: { $0.id == speaker.id })
                    }
                }
                
                try! realm.write {
                    realm.delete(self.speakersQuery())
                }
                self.data = self.speakers
                try! realm.write {
                    realm.add(self.data)
                }
            }
            self.refreshControl?.endRefreshing()
        }
    }
    
    func backTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // TODO: Override query() function when swift supports that!
    func speakersQuery() -> Results<Speaker> {
        return super.query().filter("tag == %@", self.tag)
    }
    
    func getURLSuffix() -> String {
        // Override this
        return "none"
    }
}
