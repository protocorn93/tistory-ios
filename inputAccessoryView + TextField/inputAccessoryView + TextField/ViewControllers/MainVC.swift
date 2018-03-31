//
//  MainVC.swift
//  inputAccessoryView + TextField
//
//  Created by 이동건 on 2018. 3. 31..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class MainVC: UITableViewController {
    
    var text:[String] = []
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Input message.."
        textField.textAlignment = .left
        return textField
    }()
    lazy var containerView:UIView? = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 60)
        
        let separator = UIView()
        separator.backgroundColor = .darkGray
        view.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        let textField = self.inputTextField
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "icon_photo_select"), for: .normal)
        button.contentMode = .scaleAspectFill
        
        let sendBtn = UIButton()
        sendBtn.setTitleColor(.black, for: .normal)
        sendBtn.setTitle("Send", for: .normal)
        sendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        sendBtn.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        
        view.addSubview(button)
        view.addSubview(textField)
        view.addSubview(sendBtn)
        textField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        sendBtn.translatesAutoresizingMaskIntoConstraints = false
        
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        sendBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -8).isActive = true
        sendBtn.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sendBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        textField.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 16).isActive = true
        textField.trailingAnchor.constraint(equalTo: sendBtn.leadingAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        tableView.keyboardDismissMode = .interactive
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
}

extension MainVC {
    //MARK:- inputAccessoryView
    override var inputAccessoryView: UIView? {
        get{
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    @objc func dismissKeyboard(){
        inputTextField.resignFirstResponder()
    }
    @objc func handleSendMessage(){
        guard let inputText = inputTextField.text, inputText.count != 0 else {return}
        text.append(inputText)
        inputTextField.text = nil
        tableView.reloadData()
    }
}

extension MainVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return text.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = text[indexPath.row]
        return cell
    }
}
