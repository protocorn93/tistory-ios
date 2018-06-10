//
//  ViewController.swift
//  Advanced Generics
//
//  Created by 이동건 on 10/06/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit

class CourseViewController: UITableViewController {
    
    var homeFeed:HomeFeed?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "Courses"
//        APIService.shared.fetchHomeFeed(url: URL(string: APIUrl.homeFeed.rawValue)) { (homeFeeds) in
//            self.homeFeed = homeFeeds
//            self.tableView.reloadData()
//        }
        
        APIService.shared.fetch(url: URL(string: APIUrl.homeFeed.rawValue)) { (homeFeed: HomeFeed) in
            self.homeFeed = homeFeed
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let homeFeeds = homeFeed {
            return homeFeeds.videos.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = homeFeed?.videos[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let homeFeed = homeFeed else {return}
        tableView.deselectRow(at: indexPath, animated: true)
        let courseDetailTableVC = CourseDetailTableViewController(id: homeFeed.videos[indexPath.row].id, title: homeFeed.videos[indexPath.row].name)
        navigationController?.pushViewController(courseDetailTableVC, animated: true)
    }
}

