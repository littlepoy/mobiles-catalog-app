//
//  UILabelExtension.swift
//  Mobiles catalog app
//
//  Created by Little Poy on 30/12/2562 BE.
//  Copyright © 2562 littlepoy. All rights reserved.
//

import UIKit

extension UILabel {
    
    func priceFormat(price: Float) {
        self.text = "Price: $" + String(price)
    }
    
    func ratingFormat(rating: Float) {
        self.text = "Rating: " + String(rating)
    }
    
}
