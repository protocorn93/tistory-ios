//
//  MainVC.swift
//  cornerRadius + Shadow
//
//  Created by 이동건 on 2018. 4. 17..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var radiusView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
    }
    fileprivate func setupViews(){
        self.view.addSubview(shadowView)
        shadowView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        shadowView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        shadowView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        shadowView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        shadowView.layer.shadowRadius = 20
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.cornerRadius = 20
    }
}
