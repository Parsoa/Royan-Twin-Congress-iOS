//
//  Extensions.swift
//  TwinCongress
//
//  Created by Mohammad Amin Borghei on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit

extension UILabel {
    func config(text: String?, size: CGFloat, alignment: NSTextAlignment = .left, numberOfLines: Int = 0, textColorIn: UIColor = UIColor.darkText, textBold: Bool = false) {
        
        // TODO: WTF is that?
        if text == nil || text == "???" || text == "??" || text == "111" || text == "ccc" || text == "-" || text == "0" {
            self.text = "N/A"
        } else {
            self.text = text
        }
        
        self.textColor = textColorIn
        if (textBold){
            self.font = UIFont(name: "Avenir-Heavy", size: size)
        }else {
            self.font = UIFont(name: "Avenir", size: size)
        }
        self.numberOfLines = numberOfLines
        self.textAlignment = alignment
    }
}

extension UIImageView {
    func circle(){
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 0
    }
}

extension UIViewController {
    static func root() -> UIViewController {
        let rootViewController = UITabBarController()
        
        rootViewController.viewControllers =
            [
            UINavigationController(rootViewController: HomeViewController()),
            UINavigationController(rootViewController: BookmarksViewController()),
            UINavigationController(rootViewController: CompaniesViewController()),
            UINavigationController(rootViewController: AgendaViewController()),
            UINavigationController(rootViewController: MapViewController()),
        ]
        
        return rootViewController
    }
    
    func addDismissButton(action: Selector?) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: action)
        let font = UIFont.systemFont(ofSize: 15)
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
    }
}
