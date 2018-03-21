//
//  Identifier.swift
//  CollectionView + UILongPressGestureRecognizer
//
//  Created by 이동건 on 2018. 3. 21..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

extension NSObject {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
