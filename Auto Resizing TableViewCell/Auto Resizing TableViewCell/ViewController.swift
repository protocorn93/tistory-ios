//
//  ViewController.swift
//  Auto Resizing TableViewCell
//
//  Created by 이동건 on 2018. 6. 5..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    let dataForTableView = [("I have not failed. I’ve just found 10,000 ways that won’t work.","Thomas A. Edison"), ("A man is but the product of his thoughts. What he thinks, he becomes.","Mahatma Gandhi"), ("Amateurs sit and wait for inspiration, the rest of us just get up and go to work."," Stephen King"), ("Wisdom is not a product of schooling but of the lifelong attempt to acquire it.","Albert Einstein"),("Finish each day and be done with it. You have done what you could. Some blunders and absurdities no doubt crept in; forget them as soon as you can. Tomorrow is a new day. You shall begin it serenely and with too high a spirit to be encumbered with your old nonsense.","Ralph Waldo Emerson")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100 // 대략적인 값
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForTableView.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resizablecell", for: indexPath) as! ResizableCell
        cell.quoteLabel.text = dataForTableView[indexPath.row].0
        cell.authorLabel.text = dataForTableView[indexPath.row].1
        
        return cell
    }
}

