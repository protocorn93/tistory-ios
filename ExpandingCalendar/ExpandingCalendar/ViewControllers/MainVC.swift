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
    var customCalendarView = CustomCalendarView.initFromNib()
    var customCalendarViewHeightConstraint: NSLayoutConstraint!
    
    var dropCalendarButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        button.setImage(#imageLiteral(resourceName: "show_calendar"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "hide_calendar"), for: .selected)
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var anotherView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return UIStatusBarStyle.lightContent
        }
    }
    
    fileprivate func setupViews(){
        self.view.addSubview(customCalendarView)
        customCalendarView.translatesAutoresizingMaskIntoConstraints = false
        customCalendarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        customCalendarView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        customCalendarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        customCalendarView.maximizedCalendarHeightAnchor.constant = 0
        customCalendarViewHeightConstraint = customCalendarView.heightAnchor.constraint(equalToConstant: 150)
        customCalendarViewHeightConstraint.isActive = true
        
        self.view.addSubview(dropCalendarButton)
        dropCalendarButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        dropCalendarButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        dropCalendarButton.topAnchor.constraint(equalTo: customCalendarView.bottomAnchor).isActive = true
        dropCalendarButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        dropCalendarButton.addTarget(self, action: #selector(handleDropCalendarButton), for: .touchUpInside)
        self.view.addSubview(anotherView)
        anotherView.topAnchor.constraint(equalTo: dropCalendarButton.bottomAnchor).isActive = true
        anotherView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        anotherView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        anotherView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func handleDropCalendarButton(){
        dropCalendarButton.isSelected = !dropCalendarButton.isSelected
        if dropCalendarButton.isSelected {
            customCalendarViewHeightConstraint.constant = 410
            customCalendarView.maximizedCalendarHeightAnchor.constant = 320
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
                self.customCalendarView.minimizedCalendarView.alpha = 0
                self.customCalendarView.maximizedCalendarView.alpha = 1
            }, completion: nil)
        }else{
            customCalendarViewHeightConstraint.constant = 150
            customCalendarView.maximizedCalendarHeightAnchor.constant = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
                self.customCalendarView.minimizedCalendarView.alpha = 1
                self.customCalendarView.maximizedCalendarView.alpha = 0
            }, completion: nil)
        }
    }
}

//class MainVC: UIViewController {
//    @IBOutlet weak var yearLabel: UILabel!
//    @IBOutlet weak var monthLabel: UILabel!
//    let formatter = DateFormatter()
//    @IBOutlet weak var calendarCollectionView: JTAppleCalendarView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        calendarCollectionView.visibleDates { (visibleDates) in
//            guard let date = visibleDates.monthDates.first?.date else {return}
//            self.formatter.dateFormat = "yyyy"
//            self.yearLabel.text = self.formatter.string(from: date)
//
//            self.formatter.dateFormat = "MMMM"
//            self.monthLabel.text = self.formatter.string(from: date)
//        }
//        calendarCollectionView.scrollToDate(Date())
//        calendarCollectionView.minimumLineSpacing = 0
//        calendarCollectionView.minimumInteritemSpacing = 0
//        calendarCollectionView.allowsMultipleSelection = true
//        calendarCollectionView.ibCalendarDelegate = self
//        calendarCollectionView.ibCalendarDataSource = self
//        calendarCollectionView.backgroundColor = UIColor.themeDark
//        calendarCollectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseIdentifier)
//    }
//}
//
//extension MainVC: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
//    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
//    }
//
//    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
//        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: CustomCell.reuseIdentifier, for: indexPath) as! CustomCell
//        handleCellSelected(view: cell, cellState: cellState)
//        handleCellTextColor(view: cell, cellState: cellState)
//        cell.dateLabel.text = cellState.text
//        return cell
//    }
//
//    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
//        formatter.dateFormat = "yyyy MM dd"
//        formatter.timeZone = Calendar.current.timeZone
//        formatter.locale = Calendar.current.locale
//        let startDate = formatter.date(from: "2018 01 01")!
//        let endDate = formatter.date(from: "2018 12 31")!
//        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
//        return parameters
//    }
//
//    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
//        handleCellSelected(view: cell, cellState: cellState)
//        handleCellTextColor(view: cell, cellState: cellState)
//    }
//
//    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
//        handleCellSelected(view: cell, cellState: cellState)
//        handleCellTextColor(view: cell, cellState: cellState)
//    }
//
//    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
//        guard let date = visibleDates.monthDates.first?.date else {return}
//        formatter.dateFormat = "yyyy"
//        yearLabel.text = formatter.string(from: date)
//
//        formatter.dateFormat = "MMMM"
//        monthLabel.text = formatter.string(from: date)
//
//    }
//
//    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
//        guard let vaildCell = view as? CustomCell else {return}
//        if vaildCell.isSelected{
//            vaildCell.dateLabel.textColor = UIColor.themeWhite
//        }else{
//            if cellState.dateBelongsTo == .thisMonth {
//                vaildCell.dateLabel.textColor = UIColor.themeLightGreen
//            }else{
//                vaildCell.dateLabel.textColor = .gray
//            }
//        }
//    }
//
//    func handleCellSelected(view: JTAppleCell?, cellState: CellState){
//        guard let vaildCell = view as? CustomCell else {return}
//        if vaildCell.isSelected {
//            vaildCell.containerView.isHidden = false
//            vaildCell.dateLabel.textColor = UIColor.themeWhite
//        }else{
//            vaildCell.containerView.isHidden = true
//            vaildCell.dateLabel.textColor = UIColor.themeLightGreen
//        }
//    }
//}

