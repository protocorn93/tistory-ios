//
//  APIService.swift
//  JSONEncoding & Decoding
//
//  Created by 이동건 on 2018. 6. 2..
//  Copyright © 2018년 이동건. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    static let shared = APIService()
    private init(){}
    
    func request(completion: @escaping ([Store])->()){
        Alamofire.request("https://warm-plains-89822.herokuapp.com/store/all", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            // JSONDecoder
            
            guard let data = response.data else {return}
            do{
                let stores = try JSONDecoder().decode([Store].self, from: data)
                completion(stores)
            }catch {
                print(error.localizedDescription)
            }
            
            // Original
            /*
            guard let result = response.result.value as? [[String:Any]] else {return}
            var stores:[Store] = []
            result.forEach({ (store) in
                guard let name = store["store_name"] as? String else {return}
                guard let uuid = store["store_beacon_uuid"] as? String else {return}
                guard let major = store["store_beacon_major"] as? Int else {return}
                guard let minor = store["store_beacon_minor"] as? Int else {return}
                guard let image_url = store["store_img"] as? String else {return}
                
                stores.append(Store(name: name, uuid: uuid, major: major, minor: minor, image_url: image_url))
            })
            */
            completion(stores)
        }
    }
}
