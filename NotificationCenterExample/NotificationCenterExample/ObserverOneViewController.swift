//
//  ObserverOneViewController.swift
//  NotificationCenterExample
//
//  Created by 이동건 on 2017. 11. 20..
//  Copyright © 2017년 이동건. All rights reserved.
//

import UIKit

class ObserverOneViewController: UIViewController {

    @IBOutlet weak var hiddenLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showLabel), name: NSNotification.Name(rawValue: "PostButton"), object: nil)
    }
    
    @objc func showLabel(){
        hiddenLabel.layer.isHidden = false
    }
}
