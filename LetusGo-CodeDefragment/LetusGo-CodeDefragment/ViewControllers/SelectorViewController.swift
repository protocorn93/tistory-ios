//
//  SelectorViewController.swift
//  LetusGo-CodeDefragment
//
//  Created by 이동건 on 21/07/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit

class KeyboardEventWrapper {
    var onKeyboardWillShowCallBack: (Notification) -> () = { s_ in }

    init(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onKeyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    @objc func onKeyboardWillShow(_ notification: Notification) {
        onKeyboardWillShowCallBack(notification)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

class SelectorViewController: UIViewController {
    
    var keyboardEventWrapper: KeyboardEventWrapper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardEvent()
    }
    
    func setupKeyboardEvent(){
        keyboardEventWrapper = KeyboardEventWrapper()
        keyboardEventWrapper.onKeyboardWillShowCallBack =  { _ in
            print("Keyboard will Show")
        }
    }
}
