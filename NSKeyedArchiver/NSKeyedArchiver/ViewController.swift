//
//  ViewController.swift
//  NSKeyedArchiver
//
//  Created by 이동건 on 2017. 12. 19..
//  Copyright © 2017년 이동건. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var todo:[ToDo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        
        self.load()
    }
}

// MARK: Data Method

extension ViewController {
    func save(){
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: todo)
        UserDefaults.standard.setValue(encodedData, forKey: "todo")
    }
    
    func load(){
        guard let encodedData = UserDefaults.standard.value(forKeyPath: "todo") as? Data else { return  }
        
        todo = NSKeyedUnarchiver.unarchiveObject(with: encodedData) as! [ToDo]
    }
}

// MARK: Target-Action

extension ViewController {
    @objc func add(){
        let alert = UIAlertController(title: "New ToDo", message:  "Fill the blank", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Title"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Description"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            guard let title = alert.textFields?[0].text, !title.isEmpty else {return}
            self.todo.append(ToDo(title: title, description: (alert.textFields?[1].text)!))
            self.tableView.reloadData()
            self.save()
        }))
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todocell", for: indexPath)
        
        cell.textLabel?.text = todo[indexPath.row].title
        cell.detailTextLabel?.text = todo[indexPath.row].desc
        
        return cell
    }
}

// MARK: UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
