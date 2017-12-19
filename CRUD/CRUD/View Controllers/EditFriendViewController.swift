//
//  AddFriendViewController.swift
//  CRUD
//
//  Created by 이동건 on 2017. 12. 15..
//  Copyright © 2017년 이동건. All rights reserved.
//

import UIKit


class EditFriendViewController: UIViewController {

    @IBOutlet weak var textFieldTableView: UITableView!
    
    var friend: Friend?
    var nameTextField: UITextField!
    var phoneTextField: UITextField!
    
    var editFriend: ((Friend)->Bool)?
    
    init(friend: Friend?) {
        self.friend = friend
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if friend != nil {
            title = "Edit Friend"
        }else {
            title = "Add Friend"
        }
        
        textFieldTableView.delegate = self
        textFieldTableView.dataSource = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        
        textFieldTableView.register(UINib(nibName: TextFieldCell.reuseableIdentifier, bundle:nil), forCellReuseIdentifier: TextFieldCell.reuseableIdentifier)
    }
}

// MARK: Target-Action
extension EditFriendViewController {
    @objc func cancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func save(){
        guard let name = nameTextField.text, let phone = phoneTextField.text, !name.isEmpty else { return }
        
        let alert = UIAlertController(title: "중복", message: "이미 존재하는 그룹명입니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        if let friend = friend {
            let previousName = friend.name
            friend.name = name
            friend.phone = phone
            if !editFriend!(friend) {
                present(alert, animated: true, completion: nil)
                friend.name = previousName
                return
            }
        }else {
            if !editFriend!(Friend(name: name, phone: phone)) { // 이름이 존재
                present(alert, animated: true, completion: nil)
                return
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

// MARK: UITableViewDataSource
extension EditFriendViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.reuseableIdentifier, for: indexPath) as! TextFieldCell
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.label.text = "Name:"
                if friend != nil {
                    cell.textField.text = friend?.name
                }else{
                    cell.textField.placeholder = "이름을 입력하세요."
                }
                nameTextField = cell.textField
                return cell
            }else if indexPath.row == 1 {
                cell.label.text = "Phone:"
                if friend != nil  {
                    cell.textField.text = friend?.phone
                }else{
                    cell.textField.placeholder = "-를 포함하여 입력해주세요."
                }
                phoneTextField = cell.textField
                return cell
            }
        }else if indexPath.section == 1 {
            let cell = UITableViewCell()
            cell.textLabel?.textColor = .red
            cell.textLabel?.text = "Remove"
            cell.textLabel?.textAlignment = .center
        
            return cell
        }
        
        
        return UITableViewCell()
    }
}

// MARK: UITableViewDelegate
extension EditFriendViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            tableView.deselectRow(at: indexPath, animated: true)
            let alert = UIAlertController(title: "삭제", message: "데이터를 삭제하시겠습니까?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
                NotificationCenter.default.post(name: Friend.didDelete, object: self.friend)
                self.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
        }
    }
}
