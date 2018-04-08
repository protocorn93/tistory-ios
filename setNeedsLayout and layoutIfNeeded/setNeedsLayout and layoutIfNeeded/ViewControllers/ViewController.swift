//
//  ViewController.swift
//  setNeedsLayout and layoutIfNeeded
//
//  Created by 이동건 on 2018. 3. 25..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class CustomView:UIView {
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        print("layoutIfNeeded")
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        print("setNeedsLayout")
    }
}

class ViewController: UIViewController {
   
    var containerView: CustomView = {
       let view = CustomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    var targetView:UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var targetViewHeightConstraintLayout: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBarItem()
    }
    fileprivate func setupNavBarItem(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "height", style: .plain, target: self, action: #selector(handleHeightValue))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "alpha", style: .plain, target: self, action: #selector(handleAlphaValue))
    }
    
    fileprivate func setupView(){
        self.view.addSubview(containerView)
        containerView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        view.addSubview(targetView)
        targetView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        targetView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        targetView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        targetViewHeightConstraintLayout = targetView.heightAnchor.constraint(equalToConstant: 150)
        targetViewHeightConstraintLayout.isActive = true
    }
    @objc fileprivate func handleAlphaValue(){
        UIView.animate(withDuration: 1) {
            if self.targetView.alpha == 1 {
                self.targetView.alpha = 0.5
            }else if self.targetView.alpha == 0.5 {
                self.targetView.alpha = 1
            }
        }
    }
    
    @objc fileprivate func handleHeightValue(){
        if targetViewHeightConstraintLayout.constant == 20 {
            targetViewHeightConstraintLayout.constant = 150
        }else if targetViewHeightConstraintLayout.constant == 150 {
            targetViewHeightConstraintLayout.constant = 20
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
