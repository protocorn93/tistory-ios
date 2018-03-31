//
//  MainVC.swift
//  UIPanGesture Tutorial
//
//  Created by 이동건 on 2018. 4. 1..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit
import AVKit

class MainVC: UIViewController {
    
    lazy var sideVolumeIndicator:UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var currentOutputVolume:Float!
    var sideVolumeHeightConstraint:NSLayoutConstraint!
    var panGestureStartPoint:CGPoint!
    var panGestureEndPoint:CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:))))
        setupSideVolumeIndicator()
    }
    
    func setupSideVolumeIndicator(){
        self.view.addSubview(sideVolumeIndicator)
        sideVolumeIndicator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        sideVolumeIndicator.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        sideVolumeIndicator.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        currentOutputVolume = AVAudioSession.sharedInstance().outputVolume
        print(currentOutputVolume)
        let volumeHeightConstant = self.view.frame.height * CGFloat(currentOutputVolume)
        sideVolumeHeightConstraint = sideVolumeIndicator.heightAnchor.constraint(equalToConstant: volumeHeightConstant)
        sideVolumeHeightConstraint.isActive = true
    
    }
    
    @objc func handlePanGesture(_ gesture: UIGestureRecognizer) {
        if gesture.state == .began {
            panGestureStartPoint = gesture.location(in: self.view)
            UIView.animate(withDuration: 1, animations: {
                self.sideVolumeIndicator.alpha = 1
            })
            print("Start")
        }else if gesture.state == .changed {
            let location = gesture.location(in: self.view)
            let constant = panGestureStartPoint.y - location.y
            print(constant)
            sideVolumeHeightConstraint.constant += constant/60
            if sideVolumeHeightConstraint.constant >= self.view.frame.height {
                sideVolumeHeightConstraint.constant = self.view.frame.height
            }else if sideVolumeHeightConstraint.constant <= 0 {
                sideVolumeHeightConstraint.constant = 0
            }
        }else if gesture.state == .ended {
            print("Ended")
            UIView.animate(withDuration: 1, animations: {
                self.sideVolumeIndicator.alpha = 0
            })
        }
    }
}
