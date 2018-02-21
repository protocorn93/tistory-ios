//
//  MainVCViewController.swift
//  Slide menu bar
//
//  Created by 이동건 on 2018. 2. 21..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class MainVCViewController: UIViewController{
    
    lazy var menuView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        
        view.addSubview(self.menuTableView)
        self.menuTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.menuTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.menuTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.menuTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        return view
    }()
    
    lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    let slideMenuWidth:CGFloat = 150
    var menuLeftConstraints: NSLayoutConstraint?
    var menuSlideWitdthConstraints: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuView()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(menuBtnTapped))
    }

}

// MARK: Setup Menu Bar

extension MainVCViewController {
    func setupMenuView(){
        self.view.addSubview(menuView)
        guard let navbarHeight = self.navigationController?.navigationBar.frame.maxY else {return}
        
        menuSlideWitdthConstraints =  menuView.widthAnchor.constraint(equalToConstant: slideMenuWidth)
        menuSlideWitdthConstraints!.isActive = true
        menuView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: navbarHeight).isActive = true
        menuView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        menuLeftConstraints = menuView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: -slideMenuWidth)
        menuLeftConstraints!.isActive = true
        
        self.view.addSubview(mainView)
        mainView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: navbarHeight).isActive = true
        mainView.leftAnchor.constraint(equalTo: self.menuView.rightAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mainView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
    
    @objc func menuBtnTapped() {
        if menuLeftConstraints?.constant == 0 {
            menuLeftConstraints?.constant = -slideMenuWidth
            
        }else {
            menuLeftConstraints?.constant = 0
        }
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: TableView

extension MainVCViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        menuSlideWitdthConstraints?.constant = slideMenuWidth + 20
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }) { (true) in
            self.menuLeftConstraints?.constant = -self.menuSlideWitdthConstraints!.constant
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
                self.menuSlideWitdthConstraints?.constant = self.slideMenuWidth
            })
        }
    }
}

extension MainVCViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
