//
//  ImageStore.swift
//  TwinCongress
//
//  Created by Kianoosh Abbasi on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import Alamofire
import AlamofireImage

class ImageStore {
    private static var cache: [String: UIImage] = [:]
    private static let cacheSize = 200
    
    static func store(image: UIImage, withURL url: String) {
        if cache.count > cacheSize {
            cache.remove(at: cache.index(cache.startIndex, offsetBy: Int(arc4random_uniform(UInt32(cacheSize)))))
        }
        if cache[url] == nil {
            cache[url] = image
        }
    }
    
    static func search(url: String) -> UIImage? {
        return cache[url]
    }
    
    static func download(url: String?, completion: @escaping (UIImage?, Bool) -> ()) {
        let url = url ?? ""
        if let image = search(url: url) {
            completion(image, true)
        } else {
            Alamofire.request(url).validate().responseImage { response in
                let image = response.result.value
                if image != nil {
                    store(image: image!, withURL: url)
                }
                completion(image, response.result.isSuccess)
            }
        }
    }
}
