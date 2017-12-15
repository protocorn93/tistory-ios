//
//  MainViewController.swift
//  CRUD
//
//  Created by 이동건 on 2017. 12. 15..
//  Copyright © 2017년 이동건. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var friends:[Friend] = []
    
    @IBOutlet weak var friendsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Friends"
        
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    
        friendsTableView.register(UINib(nibName: FriendCell.reuseableIdentifier, bundle: nil), forCellReuseIdentifier: FriendCell.reuseableIdentifier)
    }
}

// MARK: Target-Action method

extension MainViewController {
    @objc func add(){
        let addVC = AddFriendViewController()
        addVC.delegate = self
        present(UINavigationController(rootViewController: addVC), animated: true, completion: nil)
    }
}

// MARK: FriendDataProtocol
extension MainViewController: FriendDataProtocol {
    func save(_ friend: Friend) {
        friends.append(friend)
        friendsTableView.reloadData()
    }
}

// MARK: UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.reuseableIdentifier, for: indexPath) as! FriendCell
        cell.nameLabel.text = friends[indexPath.row].name
        cell.phoneLabel.text = friends[indexPath.row].phone
        return cell
    }
}

// MARK: UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


