//
//  SingleViewController.swift
//  CALayer Example
//
//  Created by 이동건 on 20/09/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit

class SingleViewController: UIViewController {

    @IBOutlet weak var viewForLayer: UIView!
    
    var layer: CALayer {
        return viewForLayer.layer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayer()
    }
    
    private func setupLayer() {
        layer.backgroundColor = UIColor.gray.cgColor
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = viewForLayer.frame.height / 2
        
        // Shadow for single view
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 20
        layer.shadowOpacity = 0.7
    }
}
