//
//  Friend.swift
//  CRUD
//
//  Created by 이동건 on 2017. 12. 15..
//  Copyright © 2017년 이동건. All rights reserved.
//

import Foundation

class Friend: Codable{
    
    static let didDelete = Notification.Name("Friend.Delete")
    var name:String
    var phone:String
    
    init(name:String, phone:String) {
        self.name = name
        self.phone = phone
    }
}
