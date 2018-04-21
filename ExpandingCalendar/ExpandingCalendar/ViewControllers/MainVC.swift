//
//  MainVC.swift
//  ExpandingCalendar
//
//  Created by 이동건 on 2018. 4. 22..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit
import JTAppleCalendar

class MainVC: UIViewController {
    let formatter = DateFormatter()
    @IBOutlet weak var calendarCollectionView: JTAppleCalendarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarCollectionView.ibCalendarDelegate = self
        calendarCollectionView.ibCalendarDataSource = self
        calendarCollectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseIdentifier)
    }
}

extension MainVC: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: CustomCell.reuseIdentifier, for: indexPath) as! CustomCell
        cell.dateLabel.text = cellState.text
        return cell
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = formatter.date(from: "2018 12 31")!
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
}

