//
//  ViewController.swift
//  view_change_data_pass_sample1
//
//  Created by 이동건 on 2017. 11. 1..
//  Copyright © 2017년 이동건. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var friendList:[[String:String]] = [["name":"lee", "phone":"010-1111-2222"], ["name":"kim", "phone":"010-2222-3333"]]
    @IBOutlet weak var friendListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendListTableView.delegate = self
        friendListTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendcell", for: indexPath)
        cell.textLabel?.text = friendList[indexPath.row]["name"]
        cell.detailTextLabel?.text = friendList[indexPath.row]["phone"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }
    
    @IBAction func getNewFriendData(_ sender: UIStoryboardSegue){
        if let from = sender.source as? AddFriendViewController {
            var newFriend = [String:String]()
            newFriend["name"] = from.nameTextField.text
            newFriend["phone"] = from.phoneTextField.text
            friendList.append(newFriend)
            
            friendListTableView.reloadData()
        }
    }
}

