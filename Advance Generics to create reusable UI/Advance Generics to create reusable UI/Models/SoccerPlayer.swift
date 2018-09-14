//
//  SoccerPlayer.swift
//  Advance Generics to create reusable UI
//
//  Created by 이동건 on 14/09/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import Foundation

struct SoccerPlayer: Searchable {
    var name: String
    var query: String {
        return name
    }
}
