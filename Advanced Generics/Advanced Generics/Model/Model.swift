//
//  Model.swift
//  Advanced Generics
//
//  Created by 이동건 on 10/06/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import Foundation

struct CourseDetail: Decodable {
    let name:String
    let duration:String
}

struct HomeFeed: Decodable {
    let videos:[Video]
}

struct Video: Decodable {
    let id: Int
    let name: String
}
