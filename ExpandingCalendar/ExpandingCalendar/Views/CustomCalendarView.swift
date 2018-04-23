//
//  CustomCalendarView.swift
//  ExpandingCalendar
//
//  Created by 이동건 on 2018. 4. 22..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CustomCalendarView: UIView {
    //MARK: Outlets
    @IBOutlet weak var maximizedCalendarHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var maximizedCalendarView: JTAppleCalendarView!
    @IBOutlet weak var minimizedCalendarView: JTAppleCalendarView!
    //MARK: Properties
    var capturedDate:DateSegmentInfo!
    var formatter = DateFormatter()
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupMaximizedCalendarView()
        setupMinimizedCalendarView()
    }
    //MARK: Initializer
    static func initFromNib()->CustomCalendarView{
        return Bundle.main.loadNibNamed("CustomCalendarView", owner: self, options: nil)?.first as! CustomCalendarView
    }
    //MARK: Setup Views
    fileprivate func setupMaximizedCalendarView(){
        maximizedCalendarView.visibleDates { (visibleDates) in
            guard let date = visibleDates.monthDates.first?.date else {return}
            self.formatter.dateFormat = "yyyy"
            self.yearLabel.text = self.formatter.string(from: date)
            
            self.formatter.dateFormat = "MMMM"
            self.monthLabel.text = self.formatter.string(from: date)
        }
        maximizedCalendarView.scrollToDate(Date(), triggerScrollToDateDelegate: true, animateScroll: false, preferredScrollPosition: nil, extraAddedOffset: 0, completionHandler: nil)
        maximizedCalendarView.selectDates([Date()])
        maximizedCalendarView.minimumLineSpacing = 0
        maximizedCalendarView.minimumInteritemSpacing = 0
        maximizedCalendarView.allowsMultipleSelection = true
        maximizedCalendarView.ibCalendarDelegate = self
        maximizedCalendarView.ibCalendarDataSource = self
        maximizedCalendarView.backgroundColor = UIColor.themeDark
        maximizedCalendarView.alpha = 0
        maximizedCalendarView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseIdentifier)
    }
    fileprivate func setupMinimizedCalendarView(){
        maximizedCalendarView.visibleDates { (visibleDates) in
            guard let date = visibleDates.monthDates.first?.date else {return}
            self.formatter.dateFormat = "yyyy"
            self.yearLabel.text = self.formatter.string(from: date)
            
            self.formatter.dateFormat = "MMMM"
            self.monthLabel.text = self.formatter.string(from: date)
        }
        minimizedCalendarView.scrollToDate(Date())
        minimizedCalendarView.scrollToDate(Date(), triggerScrollToDateDelegate: true, animateScroll: false, preferredScrollPosition: nil, extraAddedOffset: 0, completionHandler: nil)
        minimizedCalendarView.selectDates([Date()])
        minimizedCalendarView.minimumLineSpacing = 0
        minimizedCalendarView.minimumInteritemSpacing = 0
        minimizedCalendarView.allowsMultipleSelection = true
        minimizedCalendarView.ibCalendarDelegate = self
        minimizedCalendarView.ibCalendarDataSource = self
        minimizedCalendarView.backgroundColor = UIColor.themeDark
        minimizedCalendarView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseIdentifier)
    }
}
//MARK:- CalenderView Delegates
extension CustomCalendarView: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
    }
    //MARK: cellForItemAt
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: CustomCell.reuseIdentifier, for: indexPath) as! CustomCell
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        cell.dateLabel.text = cellState.text
        return cell
    }
    //MARK: Configure Calendar
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = formatter.date(from: "2018 12 31")!
        if calendar == maximizedCalendarView {
            let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
            return parameters
        }else{
            let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: 1, calendar: Calendar.current, generateInDates: .forFirstMonthOnly, generateOutDates: .off, firstDayOfWeek: .sunday, hasStrictBoundaries: false)
            return parameters
        }
    }
    //MARK: didSelected
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    //MARK: didDeselected
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    //MARK: didScrolled
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        guard let date = visibleDates.monthDates.first?.date else {return}
        formatter.dateFormat = "yyyy"
        yearLabel.text = formatter.string(from: date)
        formatter.dateFormat = "MMMM"
        monthLabel.text = formatter.string(from: date)
        self.capturedDate = visibleDates
        
    }
    //MARK: Handle Method
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


