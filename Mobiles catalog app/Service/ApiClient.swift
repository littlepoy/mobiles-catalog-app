//
//  ApiClient.swift
//  Mobiles catalog app
//
//  Created by Little Poy on 30/12/2562 BE.
//  Copyright © 2562 littlepoy. All rights reserved.
//

import Alamofire

class ApiClient {
    
    let baseUrl = "https://scb-test-mobile.herokuapp.com/api/mobiles/"
    
    func requestMobileList(completion: @escaping ([MobileList]?, Error?)->()) {
        Alamofire.request(self.baseUrl, method: .get)
            .validate(statusCode: 200..<299)
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    self.parseJSON(data: response.data, completion: completion)
                case .failure(let error):
                    debugPrint(error)
                }
        }
    }
    
    func requestMobileImages(id: String?, completion: @escaping ([MobileList]?, Error?)->()) {
        
        guard let id = id else {
            return
        }
        
        let url = baseUrl + "/" + id + "/images"
        
        Alamofire.request(url, method: .get)
            .validate(statusCode: 200..<299)
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    self.parseJSON(data: response.data, completion: completion)
                case .failure(let error):
                    debugPrint(error)
                }
        }
    }
    
    func parseJSON(data : Data?, completion: @escaping ([MobileList]?, Error?)->()) {
        var decodeData: [MobileList]?
        var error: Error?
        guard let data = data else {
            return
        }
        
        defer {
            completion(decodeData, error)
        }
        
        do {
            decodeData = try JSONDecoder().decode(Array<MobileList>.self, from: data)
        } catch let err {
            error = err
            debugPrint(err)
        }
    }
}
