//
//  MainVCViewController.swift
//  Slide menu bar
//
//  Created by 이동건 on 2018. 2. 21..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class MainVCViewController: UIViewController {

    lazy var menuView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    lazy var menuBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Menu", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(menuBtnTapped), for: .touchUpInside)
        return button
    }()
    
    let slideMenuWidth:CGFloat = 150
    let btnWidthConstants:CGFloat = 20
    
    var menuLeftConstraintsConstants: NSLayoutConstraint?
    var btnLeftConstraintsConstants: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuView()
    }
    
    func setupMenuView(){
        self.view.addSubview(menuView)
        menuView.widthAnchor.constraint(equalToConstant: slideMenuWidth).isActive = true
        menuView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        menuView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.view.addSubview(menuBtn)
        btnLeftConstraintsConstants = menuBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: btnWidthConstants)
        btnLeftConstraintsConstants!.isActive = true
        menuBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        
        menuLeftConstraintsConstants = menuView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: -slideMenuWidth)
        menuLeftConstraintsConstants!.isActive = true
    }

    @objc func menuBtnTapped() {
        if menuLeftConstraintsConstants?.constant == 0 {
            menuLeftConstraintsConstants?.constant = -slideMenuWidth
            btnLeftConstraintsConstants?.constant = btnWidthConstants
            
        }else {
            menuLeftConstraintsConstants?.constant = 0
            btnLeftConstraintsConstants?.constant = btnWidthConstants + slideMenuWidth
        }
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
}
