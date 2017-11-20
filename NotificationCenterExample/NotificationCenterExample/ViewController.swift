//
//  ViewController.swift
//  NotificationCenterExample
//
//  Created by 이동건 on 2017. 11. 20..
//  Copyright © 2017년 이동건. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func postBtnTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PostButton"), object: nil)
    }
}

