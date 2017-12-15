//
//  MainViewController.swift
//  CRUD
//
//  Created by 이동건 on 2017. 12. 15..
//  Copyright © 2017년 이동건. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Friends"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }
}

// MARK: Target-Action method

extension MainViewController {
    @objc func add(){
        
    }
}
