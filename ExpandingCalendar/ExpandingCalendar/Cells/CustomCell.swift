//
//  CustomCell.swift
//  ExpandingCalendar
//
//  Created by 이동건 on 2018. 4. 21..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CustomCell: JTAppleCell {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.themeOrange
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.themeLightGreen
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(containerView)
        self.backgroundColor = UIColor.themeDark
        containerView.isHidden = true
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.addSubview(dateLabel)
        dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
