//
//  NSObject + Identifier.swift
//  button to Menu
//
//  Created by 이동건 on 2018. 3. 8..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

extension NSObject {
    func getIdentifier()->String {
        return String(describing: self)
    }
}
