//
//  ViewController.swift
//  view_change_data_pass_sample2
//
//  Created by 이동건 on 2017. 11. 24..
//  Copyright © 2017년 이동건. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, SaveDataDelegate{

    @IBOutlet weak var friendListTableView: UITableView!
    
    private var friendList = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendListTableView.dataSource = self
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendcell", for: indexPath)
        cell.textLabel?.text = friendList[indexPath.row]["name"]!
        cell.detailTextLabel?.text = friendList[indexPath.row]["phone"]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! AddViewController
        destination.delegate = self
    }
    
    func saveData(data saveData: [String : String]) {
        friendList.append(saveData)
        friendListTableView.reloadData()
    }
}

