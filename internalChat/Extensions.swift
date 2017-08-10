//
//  Extensions.swift
//  internalChat
//
//  Created by Jonathan Saldivar on 10/08/17.
//  Copyright © 2017 JonathanSaldivar. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{
    
    func loadImagesUsingCacheWhitURLString(urlString: String){
        
        // check cache first
        if let cacheImages = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImages
            return
        }
    
        let url = URL(string: urlString )
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error ) in
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            if let dowloadImage = UIImage(data: data!) {
            
                imageCache.setObject(dowloadImage, forKey: urlString as AnyObject)
                self.image = dowloadImage
            }
            
        }).resume()
    }

}
