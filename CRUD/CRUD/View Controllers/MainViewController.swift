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
        
        NotificationCenter.default.addObserver(self, selector: #selector(deleteFriend(_:)), name: Friend.didDelete, object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    
        friendsTableView.register(UINib(nibName: FriendCell.reuseableIdentifier, bundle: nil), forCellReuseIdentifier: FriendCell.reuseableIdentifier)
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        friendsTableView.reloadData()
    }
}

// MARK: Additional method
extension MainViewController {
    func saveData(){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(friends), forKey: "friends")
        UserDefaults.standard.synchronize()
    }
    func loadData(){
        if let data = UserDefaults.standard.object(forKey: "friends") as? Data {
            friends = try! PropertyListDecoder().decode([Friend].self, from: data)
        }
    }
}

// MARK: Target-Action method

extension MainViewController {
    @objc func deleteFriend(_ notification: Notification) {
        guard let friend = notification.object as? Friend else { return  }
        guard let index = friends.index(where: {$0.name == friend.name}) else { return  }
        
        friends.remove(at: index)
        saveData()
        friendsTableView.reloadData()
    }
    
    @objc func add(){
        let addVC = EditFriendViewController(friend: nil)
        
        addVC.editFriend = { friend in
            if self.friends.contains(where: {$0.name == friend.name}) {
                return false
            }
            self.friends.append(friend)
            self.saveData()
            self.friendsTableView.reloadData()
            return true
        }
        
        present(UINavigationController(rootViewController: addVC), animated: true, completion: nil)
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
        
        let editVC = EditFriendViewController(friend: friends[indexPath.row])
        editVC.editFriend = { friend in
            let filteredFriend = self.friends.filter({$0.name == friend.name})
            if filteredFriend.count > 1 { // 참조로 인한 본인의 것까지 검사를 하기 때문에 1 이상으로 해야한다.
                return false
            }
            self.friends[indexPath.row] = friend
            self.saveData()
            self.friendsTableView.reloadData()
            return true
        }
        present(UINavigationController(rootViewController: editVC), animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            NotificationCenter.default.post(name: Friend.didDelete, object: friends[indexPath.row])
        }
    }
    
}


