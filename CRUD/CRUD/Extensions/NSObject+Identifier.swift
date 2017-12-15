//
//  NSObject+Identifier.swift
//  CRUD
//
//  Created by 이동건 on 2017. 12. 15..
//  Copyright © 2017년 이동건. All rights reserved.
//

import Foundation

extension NSObject {
    static var reuseableIdentifier: String {
        return String(describing: self)
    }
}
