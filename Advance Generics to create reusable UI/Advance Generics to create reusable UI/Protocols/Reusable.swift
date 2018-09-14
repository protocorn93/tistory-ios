//
//  Reusable.swift
//  Advance Generics to create reusable UI
//
//  Created by 이동건 on 14/09/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit

protocol Reusable {}

extension Reusable where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}

extension UITableView {
    
    func register<T: UITableViewCell>(_:T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not deque cell with identifier")
        }
        
        return cell
    }
}
