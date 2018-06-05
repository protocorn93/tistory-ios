//
//  NSObject + reusableIdentifier.swift
//  Auto Resizing TableViewCell
//
//  Created by 이동건 on 2018. 6. 5..
//  Copyright © 2018년 이동건. All rights reserved.
//

import Foundation

extension NSObject {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
