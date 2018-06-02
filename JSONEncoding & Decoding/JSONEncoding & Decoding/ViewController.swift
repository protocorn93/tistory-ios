//
//  ViewController.swift
//  JSONEncoding & Decoding
//
//  Created by 이동건 on 2018. 6. 2..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var stores:[Store] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIService.shared.request { (stores) in
            self.stores = stores
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = stores[indexPath.row].name
        cell.detailTextLabel?.text = stores[indexPath.row].uuid
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

