//
//  ViewController.swift
//  touchEvent
//
//  Created by 이동건 on 18/06/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var previousTouch:UITouch?
    var currentTouch:UITouch?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isMultipleTouchEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touch Count : \(touches.count)")
        for (index, touch) in touches.enumerated() {
            print("\(index) : timeStamp-\(touch.timestamp) / tapCount-\(touch.tapCount)")
            // 동일한 부분에 대해 터치를 여러번 지속하면 그것을 재사용
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}

