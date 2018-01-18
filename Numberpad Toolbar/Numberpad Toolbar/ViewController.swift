//
//  ViewController.swift
//  Numberpad Toolbar
//
//  Created by 이동건 on 2018. 1. 18..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var identifierTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButtonToTextField(textField: phoneTextField)
        addButtonToTextField(textField: identifierTextField)
    }
}

extension ViewController {
    func addButtonToTextField(textField: UITextField){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        if textField == phoneTextField {
            let nextBtn = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(doneBtnPressed))
            toolBar.items = [flexibleSpace, nextBtn]
        }else if textField == identifierTextField {
            let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnPressed))
            toolBar.items = [flexibleSpace, doneBtn]
        }
        
        textField.inputAccessoryView = toolBar
    }
    
    @objc func doneBtnPressed(){
        if phoneTextField.isFirstResponder{
            identifierTextField.becomeFirstResponder()
        }else if identifierTextField.isFirstResponder{
            identifierTextField.resignFirstResponder()
        }
    }
}

