//
//  ViewController.swift
//  setNeedsLayout and layoutIfNeeded
//
//  Created by 이동건 on 2018. 3. 25..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var targetView: UIView = {
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Animate", style: .plain, target: self, action: #selector(handleAnimate))
    }
    
    fileprivate func setupView(){
        self.view.addSubview(targetView)
        targetView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        targetView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        targetView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        targetViewHeightConstraintLayout = targetView.heightAnchor.constraint(equalToConstant: 30)
        targetViewHeightConstraintLayout.isActive = true
    }
    @objc fileprivate func handleAnimate(){
        if targetViewHeightConstraintLayout.constant == 30 {
            targetViewHeightConstraintLayout.constant = 200
        }else if targetViewHeightConstraintLayout.constant == 200 {
            targetViewHeightConstraintLayout.constant = 30
        }

        UIView.animate(withDuration: 2) {
            <#code#>
        }
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
