//
//  NavigationViewController.swift
//  Storyboar Reference
//
//  Created by 이동건 on 2017. 11. 16..
//  Copyright © 2017년 이동건. All rights reserved.
//

import UIKit

class NavigationViewController: UIViewController {

    
    @IBOutlet weak var label: UILabel!
    var text:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = text

    }
}
