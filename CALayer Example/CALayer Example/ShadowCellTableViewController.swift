//
//  ShadowCellTableViewController.swift
//  CALayer Example
//
//  Created by 이동건 on 20/09/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit

class ShadowCellTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.contentView.layer.backgroundColor = UIColor.gray.cgColor
        cell.contentView.layer.borderWidth = 2
        cell.contentView.layer.backgroundColor = UIColor.darkGray.cgColor
        cell.contentView.layer.cornerRadius = 20
        
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        cell.contentView.layer.shadowOpacity = 0.7
        cell.contentView.layer.shadowRadius = 1
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
