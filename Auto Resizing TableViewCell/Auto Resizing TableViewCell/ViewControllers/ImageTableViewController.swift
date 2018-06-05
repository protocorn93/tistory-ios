//
//  ImageTableViewController.swift
//  Auto Resizing TableViewCell
//
//  Created by 이동건 on 2018. 6. 5..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class ImageTableViewController: UITableViewController {
    
    var dataForTableView:[String] = ["Andy", "Frida", "Georgia"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: ImageResizableCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: ImageResizableCell.reusableIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataForTableView.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageResizableCell.reusableIdentifier, for: indexPath) as! ImageResizableCell
        cell.artworkImageView.image = UIImage(named: "\(dataForTableView[indexPath.section])\(indexPath.row + 1)")
        return cell
    }
}
