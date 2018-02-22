//
//  LoginVC.swift
//  Login Form
//
//  Created by 이동건 on 2018. 2. 22..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        return containerView
    }()
    
    lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.borderStyle = .roundedRect
        nameTextField.placeholder = "Input name"
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return nameTextField
    }()
    
    lazy var separatorView_1: UIView = {
        let separatorView_1 = UIView()
        separatorView_1.backgroundColor = .darkGray
        separatorView_1.translatesAutoresizingMaskIntoConstraints = false
        
        return separatorView_1
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.selectedSegmentIndex = 1
        setupForm()
        segmentedControl.addTarget(self, action: #selector(formChanged), for: .valueChanged)
    }
    
    
    var containerHeightConstraint: NSLayoutConstraint?
    var emailTextFieldTopConstraint: NSLayoutConstraint?
    
    
    func setupForm(){
        self.view.addSubview(containerView)
        // x, y, w, h
        containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        
        containerHeightConstraint =  containerView.heightAnchor.constraint(equalToConstant: 92)
        containerHeightConstraint!.isActive = true
    
        containerView.addSubview(nameTextField)
        
        // x, y, w, h
        nameTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
        nameTextField.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        

        containerView.addSubview(separatorView_1)
        // x, y, w, h
        
        separatorView_1.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        separatorView_1.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
        separatorView_1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView_1.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        
        let emailTextField = UITextField()
        emailTextField.placeholder = "Input email"
        emailTextField.borderStyle = .roundedRect
        containerView.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        // x, y, w, h
        emailTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
        
        emailTextFieldTopConstraint = emailTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 31)
        emailTextFieldTopConstraint!.isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let separatorView_2 = UIView()
        separatorView_2.backgroundColor = .darkGray
        separatorView_2.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorView_2)
        // x, y, w, h
        
        separatorView_2.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        separatorView_2.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
        separatorView_2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView_2.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Input password"
        passwordTextField.borderStyle = .roundedRect
        containerView.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        // x, y, w, h
        passwordTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: separatorView_2.bottomAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc func formChanged(){
        if segmentedControl.selectedSegmentIndex == 0 {
            containerHeightConstraint?.constant = 61
            nameTextField.isHidden = true
            separatorView_1.isHidden = true
            emailTextFieldTopConstraint?.constant = 0
            
        }else {
            containerHeightConstraint?.constant = 92
            nameTextField.isHidden = false
            separatorView_1.isHidden = false
            emailTextFieldTopConstraint?.constant = 31
        }
    }
}
