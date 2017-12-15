//
//  AddFriendViewController.swift
//  CRUD
//
//  Created by 이동건 on 2017. 12. 15..
//  Copyright © 2017년 이동건. All rights reserved.
//

import UIKit

protocol FriendDataProtocol {
    func save(_ friend: Friend)
}

class AddFriendViewController: UIViewController {

    @IBOutlet weak var textFieldTableView: UITableView!
    
    var delegate:FriendDataProtocol?
    
    var nameTextField: UITextField!
    var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Friend"
        
        textFieldTableView.delegate = self
        textFieldTableView.dataSource = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        
        textFieldTableView.register(UINib(nibName: TextFieldCell.reuseableIdentifier, bundle:nil), forCellReuseIdentifier: TextFieldCell.reuseableIdentifier)
    }
}

// MARK: Target-Action
extension AddFriendViewController {
    @objc func cancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func save(){
        let name = nameTextField.text
        let phone = phoneTextField.text
        
        delegate?.save(Friend(name: name!, phone: phone!))
        dismiss(animated: true, completion: nil)
    }
}

// MARK: UITableViewDataSource
extension AddFriendViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.reuseableIdentifier, for: indexPath) as! TextFieldCell
        if indexPath.row == 0 {
            cell.label.text = "Name:"
            cell.textField.placeholder = "이름을 입력하세요."
            nameTextField = cell.textField
            return cell
        }else if indexPath.row == 1 {
            cell.label.text = "Phone:"
            cell.textField.placeholder = "-를 포함하여 입력해주세요."
            phoneTextField = cell.textField
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: UITableViewDelegate
extension AddFriendViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
