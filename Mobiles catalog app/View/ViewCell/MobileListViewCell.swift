//
//  MobileListViewCell.swift
//  Mobiles catalog app
//
//  Created by Little Poy on 29/12/2562 BE.
//  Copyright © 2562 littlepoy. All rights reserved.
//

import Foundation
import UIKit

protocol MobileListViewDelegate {
    func touchUpFavButton(index: Int)
}

class MobileListViewCell: UITableViewCell {
    
    @IBOutlet weak var mobileImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    var delegate: MobileListViewDelegate?
    var index: Int?
    
    @IBAction func favoriteButtonOnClick(_ sender: UIButton) {
        print("Fav Button tab")
        
        if favoriteButton.isSelected == true {
          favoriteButton.isSelected = false
        } else {
          favoriteButton.isSelected = true
        }
        
        if let index = index {
            delegate?.touchUpFavButton(index: index)
        }
    }
}
