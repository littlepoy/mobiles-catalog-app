//
//  MobileList.swift
//  Mobiles catalog app
//
//  Created by Little Poy on 30/12/2562 BE.
//  Copyright © 2562 littlepoy. All rights reserved.
//

struct MobileList: Codable {
    
    let id : Int
    let name : String?
    let thumbImageURL : String?
    let description : String?
    let price : Float
    let rating : Float
    
    private enum CodingKeys : String, CodingKey {
        case id = "id"
        case name = "name"
        case thumbImageURL = "thumbImageURL"
        case description = "description"
        case price = "price"
        case rating = "rating"
    }
}

