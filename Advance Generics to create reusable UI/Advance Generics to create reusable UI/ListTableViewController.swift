//
//  ListTableViewController.swift
//  Advance Generics to create reusable UI
//
//  Created by 이동건 on 14/09/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit

class ListTableViewController: BaseTableViewSearchController<SoccerCell, SoccerPlayer> {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let soccerPlayers = [
            SoccerPlayer(name: "Messi"),
            SoccerPlayer(name: "Ronaldo"),
            SoccerPlayer(name: "Modric"),
            SoccerPlayer(name: "Guerrero"),
            SoccerPlayer(name: "Rodriguez"),
            SoccerPlayer(name: "Kane"),
            SoccerPlayer(name: "Ramos"),
            SoccerPlayer(name: "Pique"),
            SoccerPlayer(name: "Mbape"),
            SoccerPlayer(name: "Pogba"),
            SoccerPlayer(name: "Zidane"),
            SoccerPlayer(name: "Kross"),
            SoccerPlayer(name: "Puyol"),
            SoccerPlayer(name: "Beckham")
        ]
        
        self.models = soccerPlayers
    }
}
