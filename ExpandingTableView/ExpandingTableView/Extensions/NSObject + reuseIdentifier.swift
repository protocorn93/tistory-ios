//
//  NSObject + reuseIdentifier.swift
//  ExpandingTableView
//
//  Created by 이동건 on 2018. 4. 21..
//  Copyright © 2018년 이동건. All rights reserved.
//

import Foundation

extension NSObject{
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
