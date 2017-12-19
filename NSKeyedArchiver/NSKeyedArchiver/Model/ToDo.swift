//
//  ToDo.swift
//  NSKeyedArchiver
//
//  Created by 이동건 on 2017. 12. 19..
//  Copyright © 2017년 이동건. All rights reserved.
//

import Foundation

class ToDo: NSObject, NSCoding {
    init(title:String, description: String) {
        self.title = title
        self.desc = description
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.desc, forKey: "desc")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: "title") as? String ,
        let desc = aDecoder.decodeObject(forKey: "desc") as? String  else { return nil }
        
        self.init(title: title, description: desc)
    }
    
    var title: String
    var desc: String
}
