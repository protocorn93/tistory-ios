//
//  ViewController.swift
//  touchEvent
//
//  Created by 이동건 on 18/06/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit

class CustomView: UIView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("========================== Began")
        print("Event Object : \(Unmanaged.passUnretained(event!).toOpaque())")
        for (index, touch) in touches.enumerated() {
            print("\(index)'s, UITouch Object : \(Unmanaged.passUnretained(touch).toOpaque())")
        }
    }
}

class CustomButton: UIButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("UIRESPONDER : Button Touch Began")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        print("UIRESPONDER : Button Touch Cancelld")
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        print("UIRESPONDER : Button Touch Ended")
    }
    
    override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        super.sendAction(action, to: target, for: event)
        event?.touches(for: self)?.forEach({
            switch $0.phase {
            case .began:
                print("Began")
            case .ended :
                print("Ended")
            default:
                print("Default")
            }
        })
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var button: CustomButton! {
        didSet{
            button.addTarget(self, action: #selector(buttonDidTapped), for: .touchUpInside)
            var singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapGesture(_:)))
            singleTapGesture.delaysTouchesBegan = true
//            singleTapGesture.cancelsTouchesInView = false
            button.addGestureRecognizer(singleTapGesture)
//            var doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapGesture(_:)))
//            doubleTapGesture.numberOfTapsRequired = 2
//            doubleTapGesture.cancelsTouchesInView = false
//            doubleTapGesture.delaysTouchesEnded = false
//            button.addGestureRecognizer(doubleTapGesture)
        }
    }
    @IBOutlet weak var skyBlueView: CustomView!
    var previousTouch:UITouch?
    var currentTouch:UITouch?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isMultipleTouchEnabled = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Second", style: .plain, target: self, action: #selector(handleShowSecondViewController))
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("========================== Motion Began")
        print("Root ViewController Event Object : \(ObjectIdentifier(event!))")
        switch event!.type {
        case .touches:
            print("Touch Events")
        case .presses:
            print("Press Events")
        case .motion:
            print("Motion Events")
        case .remoteControl:
            print("Remote Control Event")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("========================== Began")
        print("Root ViewController Event Object : \(ObjectIdentifier(event!))")
        switch event!.type {
        case .touches:
            print("Touch Events")
        case .presses:
            print("Press Events")
        case .motion:
            print("Motion Events")
        case .remoteControl:
            print("Remote Control Event")
        }
        touches.forEach{print("Touch Object : \(ObjectIdentifier($0)) tapCount: \($0.tapCount)")}
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("========================== Moved")
        touches.forEach{print("Touch Object : \(ObjectIdentifier($0))")}
    }
    
    @objc func handleShowSecondViewController(){
        self.navigationController?.pushViewController(SecondViewController(), animated: true)
    }
    
    @objc func buttonDidTapped(sender: UIButton){
        print("TARGET-ACTION : Button Did Tapped")
    }
    
    @objc func buttonTapGesture(_ gesture: UITapGestureRecognizer){
        print("UIGestureRecognizer : UITapGestureRecognizer")
    }
}
