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
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    let formatter = DateFormatter()
    @IBOutlet weak var calendarCollectionView: JTAppleCalendarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarCollectionView.visibleDates { (visibleDates) in
            guard let date = visibleDates.monthDates.first?.date else {return}
            self.formatter.dateFormat = "yyyy"
            self.yearLabel.text = self.formatter.string(from: date)
            
            self.formatter.dateFormat = "MMMM"
            self.monthLabel.text = self.formatter.string(from: date)
        }
        calendarCollectionView.minimumLineSpacing = 0
        calendarCollectionView.minimumInteritemSpacing = 0
        calendarCollectionView.allowsMultipleSelection = true
        calendarCollectionView.ibCalendarDelegate = self
        calendarCollectionView.ibCalendarDataSource = self
        calendarCollectionView.backgroundColor = UIColor.themeDark
        calendarCollectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseIdentifier)
    }
}

extension MainVC: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: CustomCell.reuseIdentifier, for: indexPath) as! CustomCell
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
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
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        guard let date = visibleDates.monthDates.first?.date else {return}
        formatter.dateFormat = "yyyy"
        yearLabel.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMMM"
        monthLabel.text = formatter.string(from: date)
        
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let vaildCell = view as? CustomCell else {return}
        if vaildCell.isSelected{
            vaildCell.dateLabel.textColor = UIColor.themeWhite
        }else{
            if cellState.dateBelongsTo == .thisMonth {
                vaildCell.dateLabel.textColor = UIColor.themeLightGreen
            }else{
                vaildCell.dateLabel.textColor = .gray
            }
        }
    }
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState){
        guard let vaildCell = view as? CustomCell else {return}
        if vaildCell.isSelected {
            vaildCell.containerView.isHidden = false
            vaildCell.dateLabel.textColor = UIColor.themeWhite
        }else{
            vaildCell.containerView.isHidden = true
            vaildCell.dateLabel.textColor = UIColor.themeLightGreen
        }
    }
    
    
}

