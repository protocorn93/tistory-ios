//
//  ViewController.swift
//  LetusGo-CodeDefragment
//
//  Created by 이동건 on 21/07/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit

// 코드 응집도 증가
class BaseViewController: UIViewController {
    var viewWillAppearAction: [(Bool)->()] = []
    var viewWillDisappearAction: [(Bool)->()] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearAction.forEach({$0(animated)})
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearAction.forEach({$0(animated)})
    }
}

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    func setupNavigationBar(){
        viewWillAppearAction.append { [weak self] animation in
            self?.navigationController?.setNavigationBarHidden(false, animated: animation)
        }
        
        viewWillAppearAction.append { [weak self]  animation in
            self?.navigationController?.setNavigationBarHidden(true, animated: animation)
        }
    }
}

