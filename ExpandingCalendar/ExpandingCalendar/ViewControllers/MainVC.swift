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
    //MARK: Properties
    var customCalendarView = CustomCalendarView.initFromNib()
    var selectedDates:[Date] = []
    var customCalendarViewHeightConstraint: NSLayoutConstraint!
    //MARK: Outlets
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
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    //MARK: Setup Views
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
    
}
//MARK:- Handle Drop Calenda
extension MainVC {
    @objc func handleDropCalendarButton(){
        dropCalendarButton.isSelected = !dropCalendarButton.isSelected
        guard let date = customCalendarView.capturedDate.monthDates.first?.date else {return}
        if dropCalendarButton.isSelected { // open
            customCalendarView.maximizedCalendarView.scrollToDate(date)
            customCalendarViewHeightConstraint.constant = 410
            customCalendarView.maximizedCalendarHeightAnchor.constant = 320
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
                self.customCalendarView.minimizedCalendarView.alpha = 0
                self.customCalendarView.maximizedCalendarView.alpha = 1
            }, completion: nil)
            self.selectedDates = customCalendarView.minimizedCalendarView.selectedDates
            customCalendarView.maximizedCalendarView.deselectAllDates()
            customCalendarView.maximizedCalendarView.selectDates(customCalendarView.minimizedCalendarView.selectedDates)
        }else{                              // close
            customCalendarView.minimizedCalendarView.scrollToDate(date)
            customCalendarViewHeightConstraint.constant = 150
            customCalendarView.maximizedCalendarHeightAnchor.constant = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
                self.customCalendarView.minimizedCalendarView.alpha = 1
                self.customCalendarView.maximizedCalendarView.alpha = 0
                self.customCalendarView.minimizedCalendarView.scrollToDate(Date())
            }, completion: nil)
            self.selectedDates = customCalendarView.maximizedCalendarView.selectedDates
            customCalendarView.minimizedCalendarView.deselectAllDates()
            customCalendarView.minimizedCalendarView.selectDates(customCalendarView.maximizedCalendarView.selectedDates)
        }
    }
}
