//
//  Store.swift
//  JSONEncoding & Decoding
//
//  Created by 이동건 on 2018. 6. 2..
//  Copyright © 2018년 이동건. All rights reserved.
//

import Foundation

struct Store: Codable {
    var name: String?
    var uuid: String?
    var major: Int?
    var minor: Int?
    var image_url: String?
    
    /*
     json의 key 값과 json 객체를 담을 데이터 구조의 프로퍼티의 이름을 다르게 하고 싶을 때 CodingKey 프로토콜을 사용한다
     */
    enum CodingKeys: String, CodingKey {
        case name = "store_name"
        case uuid = "store_beacon_uuid"
        case major = "store_beacon_major"
        case minor = "store_beacon_minor"
        case image_url = "store_img"
    }
}
