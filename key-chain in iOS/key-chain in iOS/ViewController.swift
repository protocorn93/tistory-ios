//
//  ViewController.swift
//  key-chain in iOS
//
//  Created by 이동건 on 2018. 1. 7..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveBtnPressed(_ sender: Any) {
        if let password = textField.text {
            let saveSuccessful = KeychainWrapper.standard.set(password, forKey: "userPassword")
            print("Save was successful: \(saveSuccessful)")
            self.view.endEditing(true)
        }
    }
    @IBAction func retrieveBtnPressed(_ sender: Any) {
        let retrievedPassword: String? = KeychainWrapper.standard.string(forKey: "userPassword")
        print("Retrieved passwork is: \(retrievedPassword!)")
    }
    
}

