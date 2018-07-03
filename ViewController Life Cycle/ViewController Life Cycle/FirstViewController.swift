//
//  ViewController.swift
//  ViewController Life Cycle
//
//  Created by 이동건 on 03/07/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("FIRST VC : Initialized")
        if let label = self.label {
            print("You can access to IBOutlet. Text is \(label.text ?? "nil")")
        }else{
            print("IBOutlet NOT YET")
        }
        print("- - - - - - - - - - - - - - ")
    }
    override func loadView() {
        super.loadView()
        print("FIRST VC: loadView")
        if let label = self.label {
            print("You can access to IBOutlet. Text is \(label.text ?? "nil")")
        }else{
            print("IBOutlet NOT YET")
        }
        print("- - - - - - - - - - - - - - ")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("FIRST VC: viewDidLoad")
        if let label = self.label {
            print("You can access to IBOutlet. Text is \(label.text ?? "nil")")
        }else{
            print("IBOutlet NOT YET")
        }
        print("- - - - - - - - - - - - - - ")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("FIRST VC: viewWillAppear")
        if let label = self.label {
            print("You can access to IBOutlet. Text is \(label.text ?? "nil")")
        }else{
            print("IBOutlet NOT YET")
        }
        print("- - - - - - - - - - - - - - ")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("FIRST VC: viewDidAppear")
        if let label = self.label {
            print("You can access to IBOutlet. Text is \(label.text ?? "nil")")
        }else{
            print("IBOutlet NOT YET")
        }
        print("- - - - - - - - - - - - - - ")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("FIRST VC: viewWillDisappear")
        if let label = self.label {
            print("You can access to IBOutlet. Text is \(label.text ?? "nil")")
        }else{
            print("IBOutlet NOT YET")
        }
        print("- - - - - - - - - - - - - - ")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("FIRST VC: viewDidDisappear")
        if let label = self.label {
            print("You can access to IBOutlet. Text is \(label.text ?? "nil")")
        }else{
            print("IBOutlet NOT YET")
        }
        print("- - - - - - - - - - - - - - ")
    }
    
    deinit {
        print("FIRST VC: Deinitalized")
        if let label = self.label {
            print("You can access to IBOutlet. Text is \(label.text ?? "nil")")
        }else{
            print("IBOutlet NOT YET")
        }
        print("- - - - - - - - - - - - - - ")
    }
}

