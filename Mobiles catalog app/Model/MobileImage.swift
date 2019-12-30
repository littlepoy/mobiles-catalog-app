//
//  mobileImages.swift
//  Mobiles catalog app
//
//  Created by Little Poy on 30/12/2562 BE.
//  Copyright © 2562 littlepoy. All rights reserved.
//

struct MobileImage: Codable {
    
    let id : Int
    let mobileId : Int
    let imageURL : String?
    
    private enum CodingKeys : String, CodingKey {
        case id = "id"
        case mobileId = "mobile_id"
        case imageURL = "url"
       
    }
}
