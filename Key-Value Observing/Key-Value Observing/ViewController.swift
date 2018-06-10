//
//  ViewController.swift
//  Key-Value Observing
//
//  Created by 이동건 on 2018. 5. 16..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    var observations:[NSKeyValueObservation] = []
    let configurationManager = ConfigurationManager(withConfiguration: Configuration())
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label"
        return label
    }()
    
    var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Button", for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupObserver()
    }
    
    func setupObserver(){
        let dateObservation = configurationManager.configuration.observe(\.updatedAt, options: [.initial, .new]) {[weak self] (observed, changed) in
            self?.label.text = self?.configurationManager.dateFormatter.string(from: changed.newValue!)
        }
        observations.append(dateObservation)
    }
    
    func setupViews(){
        self.view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        self.view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30).isActive = true
        button.addTarget(self, action: #selector(buttonDidTapped), for: UIControl.Event.touchUpInside)
    }
    
    @objc func buttonDidTapped(){
        configurationManager.updateConfiguration()
    }
    
    deinit {
        observations.removeAll()
    }
}

