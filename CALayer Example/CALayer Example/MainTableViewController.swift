//
//  MainTableViewController.swift
//  CALayer Example
//
//  Created by 이동건 on 20/09/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    let categories: [String] = ["Single View", "TableView", "CollectionView"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if indexPath.row == 0 {
            let singleVC = storyboard.instantiateViewController(withIdentifier: "SingleViewController") as! SingleViewController
            self.navigationController?.pushViewController(singleVC, animated: true)
        }else if indexPath.row == 1 {
            let tableVC = storyboard.instantiateViewController(withIdentifier: "ShadowCellTableViewController") as! ShadowCellTableViewController
            self.navigationController?.pushViewController(tableVC, animated: true)
        }else {
            let collectionVC = storyboard.instantiateViewController(withIdentifier: "ShadowCellCollectionViewController") as! ShadowCellCollectionViewController
            self.navigationController?.pushViewController(collectionVC, animated: true)
        }
    }
}
