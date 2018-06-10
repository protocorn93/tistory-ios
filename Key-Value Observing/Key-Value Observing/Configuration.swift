//
//  Configuration.swift
//  Key-Value Observing
//
//  Created by 이동건 on 2018. 6. 9..
//  Copyright © 2018년 이동건. All rights reserved.
//

import Foundation

@objcMembers class Configuration: NSObject {
    dynamic var createdAt:Date
    dynamic var updatedAt:Date
    
    init(createdAt: Date, updatedAt: Date) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

class ConfigurationManager:NSObject {
    var configuration: Configuration
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
        return dateFormatter
    }()
    var createdAt: String {
        return dateFormatter.string(from: configuration.createdAt)
    }
    
    var updatedAt: String {
        return dateFormatter.string(from: configuration.updatedAt)
    }
    
    init(withConfiguration configuration: Configuration) {
        self.configuration = configuration
        super.init()
    }
    func updateConfiguration() {
        configuration.updatedAt = Date()
    }

}
