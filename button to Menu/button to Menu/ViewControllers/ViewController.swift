//
//  ViewController.swift
//  button to Menu
//
//  Created by 이동건 on 2018. 3. 8..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var buttonView: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Menu", for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleMenuBtnTappd), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView(){
        self.view.addSubview(buttonView)
        buttonView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true
        buttonView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        buttonView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        buttonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func handleMenuBtnTappd(){
        let startFrame = self.buttonView.frame
        let startView = UIView(frame: startFrame)
        startView.layer.cornerRadius = 10
        startView.layer.masksToBounds = true
        startView.backgroundColor = .darkGray
        
        guard let keyWindow = UIApplication.shared.keyWindow else {return}
        keyWindow.addSubview(startView)
        let animatedFrame = CGRect(x: 30, y: 200, width: self.view.frame.width - 60, height: self.view.frame.height - 500)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            startView.frame = animatedFrame
        }, completion: nil)
    }
}
