//
//  SecondViewController.swift
//  touchEvent
//
//  Created by 이동건 on 20/06/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("==========================")
        print("SecondViewController Event Object : \(Unmanaged.passUnretained(event!).toOpaque())")
        for (index, touch) in touches.enumerated() {
            print("\(index)'s, UITouch Object : \(Unmanaged.passUnretained(touch).toOpaque()) Tap Count: \(touch.tapCount)")
        }
        print("==========================")
    }
    
}
