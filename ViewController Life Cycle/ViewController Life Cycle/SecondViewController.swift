//
//  SecondViewController.swift
//  ViewController Life Cycle
//
//  Created by 이동건 on 03/07/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("SECOND VC : Initialized")
        print("- - - - - - - - - - - - - - ")
    }
    
    override func loadView() {
        super.loadView()
        print("SECOND VC: loadView")
        print("- - - - - - - - - - - - - - ")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SECOND VC: viewDidLoad")
        print("- - - - - - - - - - - - - - ")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SECOND VC: viewWillAppear")
        print("- - - - - - - - - - - - - - ")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("SECOND VC: viewDidAppear")
        print("- - - - - - - - - - - - - - ")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("SECOND VC: viewWillDisappear")
        print("- - - - - - - - - - - - - - ")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("SECOND VC: viewDidDisappear")
        print("- - - - - - - - - - - - - - ")
    }
    
    deinit {
        print("SECOND VC: Deinitalized")
        print("- - - - - - - - - - - - - - ")
    }
}
