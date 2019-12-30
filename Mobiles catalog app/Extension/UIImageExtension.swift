//
//  UIImageExtension.swift
//  Mobiles catalog app
//
//  Created by Little Poy on 30/12/2562 BE.
//  Copyright © 2562 littlepoy. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func getImageFromWeb(imageUrlString: String?) {
        if let imageUrlString = imageUrlString {
            let url: URL?
            
            if imageUrlString.hasPrefix("https://") || imageUrlString.hasPrefix("http://") {
                url = URL(string: imageUrlString)
            } else {
                url = URL(string: "https://" + imageUrlString)
            }
            
            guard let _url = url else {
                return
            }
            
            let task = URLSession.shared.dataTask(with: _url) { (data, response, error) in
                guard error == nil else {
                    print("Error: \(String(describing: error))")
                    return
                }
                guard response != nil else {
                    print("no response")
                    return
                }
                guard let data = data else {
                    print("no data")
                    return
                }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
    
}
