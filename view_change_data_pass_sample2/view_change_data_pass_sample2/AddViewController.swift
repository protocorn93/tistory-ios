//
//  AddViewController.swift
//  view_change_data_pass_sample2
//
//  Created by 이동건 on 2017. 11. 24..
//  Copyright © 2017년 이동건. All rights reserved.
//

import UIKit

protocol SaveDataDelegate:class{
    func saveData(data saveData:[String:String])
}
class AddViewController: UIViewController {

    weak var delegate:SaveDataDelegate?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func saveBtnTapped(_ sender: Any) {
        var data = [String:String]()
        data["name"] = nameTextField.text!
        data["phone"] = phoneTextField.text!
        delegate?.saveData(data: data)
        
        self.navigationController?.popViewController(animated: true)
    }
}
