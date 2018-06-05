//
//  MainTableViewController.swift
//  Auto Resizing TableViewCell
//
//  Created by 이동건 on 2018. 6. 5..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    let dataForTableView:[String] = [
        "Label",
        "TextView",
        "Image"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForTableView.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataForTableView[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(LabelTableViewController(), animated: true)
        }else if indexPath.row == 1 {
            self.navigationController?.pushViewController(ImageTableViewController(), animated: true)
        }else if indexPath.row == 2 {
            
        }
    }
}
