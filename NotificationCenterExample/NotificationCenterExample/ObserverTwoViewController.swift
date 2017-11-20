//
//  ObserverTwoViewController.swift
//  NotificationCenterExample
//
//  Created by 이동건 on 2017. 11. 20..
//  Copyright © 2017년 이동건. All rights reserved.
//

import UIKit

class ObserverTwoViewController: UIViewController {

    @IBOutlet weak var willBeHiddenLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(hideLabel), name: NSNotification.Name(rawValue: "PostButton"), object: nil)
    }
    
    @objc func hideLabel(){
        willBeHiddenLabel.layer.isHidden = true
    }
}
