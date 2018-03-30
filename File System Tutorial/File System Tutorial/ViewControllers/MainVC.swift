//
//  MainVC.swift
//  File System Tutorial
//
//  Created by 이동건 on 2018. 3. 30..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "File System"
        
        configurFile()
    }
    
    fileprivate func configurFile(){
        let fileManager = FileManager.default
        let currentPath = fileManager.currentDirectoryPath
        print("Current Path : \(currentPath)")
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].path
        print("Documents Path : \(documentsDir)")
        if fileManager.changeCurrentDirectoryPath(documentsDir) {
            print("Current Path : \(fileManager.currentDirectoryPath)")
        } else {
            print("Fail")
        }
    }
}
