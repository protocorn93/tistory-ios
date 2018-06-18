//
//  ViewController.swift
//  Overriding hitTest
//
//  Created by 이동건 on 13/06/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit

class CustomTransparentView: UIView {
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        var hitTestView = super.hitTest(point, with: event)
//        if hitTestView == self {
//            hitTestView = nil
//        }
//        return hitTestView
//    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var transparentView: CustomTransparentView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func buttonDidTapped(_ sender: UIButton) {
        print("Button Did Tapped")
    }
}

