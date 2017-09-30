//
//  ImagesViewController.swift
//  TwinCongress
//
//  Created by Kianoosh Abbasi on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit
import SwipeView

class ImagesViewController: UIViewController, SwipeViewDataSource, SwipeViewDelegate {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var swipeView: SwipeView!
    
    var images: [UIImage]
    var titles: [String]
    var imageViews: [UIImageView] = []
    
    init(images: [UIImage], titles: [String]) {
        self.images = images
        self.titles = titles
        super.init(nibName: String(describing: ImagesViewController.self), bundle: nil)
        tabBarItem = UITabBarItem(title: "Map", image: #imageLiteral(resourceName: "map"), tag: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.images = []
        self.titles = []
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeView.dataSource = self
        swipeView.delegate = self
        
        imageViews = []
        for i in 0..<images.count {
            let imageView = UIImageView(image: images[i])
            imageView.contentMode = .scaleAspectFit
            
            let label = UILabel()
            imageView.addSubview(label)
            label.config(text: titles[i], size: 17, textBold: true)
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
            label.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 10).isActive = true
            label.translatesAutoresizingMaskIntoConstraints = false
            
            imageViews.append(imageView)
        }
    }
    
    func numberOfItems(in swipeView: SwipeView!) -> Int {
        pageControl.numberOfPages = imageViews.count
        return imageViews.count
    }
    
    func swipeView(_ swipeView: SwipeView!, viewForItemAt index: Int, reusing view: UIView!) -> UIView! {
        return imageViews[index]
    }
    
    func swipeViewItemSize(_ swipeView: SwipeView!) -> CGSize {
        return swipeView.bounds.size
    }
    
    func swipeViewCurrentItemIndexDidChange(_ swipeView: SwipeView!) {
        pageControl.currentPage = swipeView.currentItemIndex
    }
    
    func swipeView(_ swipeView: SwipeView!, didSelectItemAt index: Int) {
        let controller = ImageViewController(image: images[index], name: titles[index])
        present(UINavigationController(rootViewController: controller), animated: false, completion: nil)
    }
}
