//
//  MobileListViewCell.swift
//  Mobiles catalog app
//
//  Created by Little Poy on 29/12/2562 BE.
//  Copyright © 2562 littlepoy. All rights reserved.
//

import Foundation
import UIKit

class MobileListViewCell: UITableViewCell {
    
    @IBOutlet weak var mobileImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBAction func favoriteButtonOnClick(_ sender: UIButton) {
        print("Fav Button tab")
    }
    
}
