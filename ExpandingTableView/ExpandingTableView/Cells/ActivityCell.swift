//
//  ActivityCell.swift
//  ExpandingTableView
//
//  Created by 이동건 on 2018. 4. 21..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class ActivityCell: UICollectionViewCell {
    
    var activityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        label.text = "Sample"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(activityLabel)
        self.backgroundColor = .lightGray
        activityLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
