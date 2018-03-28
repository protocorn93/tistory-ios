//
//  MainVC.swift
//  Keyboard hide TextField
//
//  Created by 이동건 on 2018. 3. 28..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var inputViewBottomAnchor: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        setupNotification()
    }
}

extension MainVC: UITextFieldDelegate{
    func setupNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        print("Keyboard hide")
        handleKeyboardIssue(notification: notification, isAppearing: false)
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        print("Keyboard show")
        handleKeyboardIssue(notification: notification, isAppearing: true)
    }
    
    fileprivate func handleKeyboardIssue(notification: Notification, isAppearing: Bool) {
        guard let userInfo = notification.userInfo as? [String:Any] else {return}
        guard let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {return}
        guard let keyboardShowAnimateDuartion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else {return}
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        let heightConstant = isAppearing ? keyboardHeight : 0
        inputViewBottomAnchor.constant = heightConstant
        UIView.animate(withDuration: keyboardShowAnimateDuartion.doubleValue) {
            self.view.layoutIfNeeded()
        }
    }
}
