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
        guard let imageUrlString = imageUrlString else {
            return
        }
        
        guard let url = URL(string: imageUrlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
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
