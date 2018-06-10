//
//  CourseDetailTableViewController.swift
//  Advanced Generics
//
//  Created by 이동건 on 10/06/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit

class CourseDetailTableViewController: UITableViewController {
    
    var id:Int
    var navTitle:String
    var courseDetails: [CourseDetail] = []
    
    init(id:Int, title:String) {
        self.id = id
        self.navTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = navTitle
//        APIService.shared.fetchCourseDetails(url: URL(string: APIUrl.courseDetail.rawValue + "\(id)")) { (courseDetails) in
//            self.courseDetails = courseDetails
//            self.tableView.reloadData()
//        }
        
        APIService.shared.fetch(url: URL(string: APIUrl.courseDetail.rawValue + "\(id)")) { (courseDetails: [CourseDetail]) in
            self.courseDetails = courseDetails
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseDetails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = courseDetails[indexPath.row].name
        return cell
    }
}
