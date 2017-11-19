//
//  ViewController.swift
//  Storyboar Reference
//
//  Created by 이동건 on 2017. 11. 16..
//  Copyright © 2017년 이동건. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNavi"{
            let destinationNavigationController = segue.destination as! UINavigationController
            let destinationTopViewController = destinationNavigationController.topViewController as! NavigationViewController
            destinationTopViewController.text = "Hello Navi"
        }
    }
}

