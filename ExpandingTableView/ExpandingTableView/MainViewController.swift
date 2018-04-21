//
//  MainViewController.swift
//  ExpandingTableView
//
//  Created by 이동건 on 2018. 4. 21..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

struct SectionData {
    var isOpended: Bool
    var title:String
//    var cellData:[String]
}

class MainViewController: UITableViewController {
    //MARK: Properties
    var sectionDatas:[SectionData] = [
        SectionData(isOpended: false, title: "Title1"),
        SectionData(isOpended: false, title: "Title2"),
        SectionData(isOpended: false, title: "Title3"),
        SectionData(isOpended: false, title: "Title4")
    ]
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = .white
        self.tableView.register(UINib(nibName: CollectionCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CollectionCell.reuseIdentifier)
    }
}
//MARK:- UITableViewDelegate, DataSource
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionDatas[section].isOpended {
            return 2
        }
        return 1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionDatas.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = sectionDatas[indexPath.section].title
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionCell.reuseIdentifier, for: indexPath) as! CollectionCell
            cell.activityCollectionView.isHidden = false
            UIView.animate(withDuration: 1, animations: {
                cell.activityCollectionView.alpha = 1
            }, completion: nil)
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 250
        }
        return 50
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            sectionDatas[indexPath.section].isOpended = sectionDatas[indexPath.section].isOpended ? false : true
            let sections = IndexSet(integer: indexPath.section)
            let menuIndexPath = IndexPath(row: 1, section: indexPath.section)
            if let cell = tableView.cellForRow(at: menuIndexPath) as? CollectionCell{ // is Menu Down?
                UIView.animate(withDuration: 0.3, animations: {
                    cell.activityCollectionView.alpha = 0
                }) { (_) in
                    cell.activityCollectionView.isHidden = true
                    tableView.reloadSections(sections, with: .none)
                }
            }else{ // Menu Should down
                tableView.reloadSections(sections, with: .none)
            }
        }
    }
}
