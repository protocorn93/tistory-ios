//
//  MainVC.swift
//  UIPanGesture Tutorial
//
//  Created by 이동건 on 2018. 4. 1..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

class MainVC: UIViewController {
    
    lazy var sideVolumeIndicator:UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var volumeView:MPVolumeView = {
        let volumeView = MPVolumeView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        volumeView.isHidden = true
        return volumeView
    }()
    
    var isDragging:Bool = false
    
    var currentOutputVolume:Float!
    var sideVolumeHeightConstraint:NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:))))
        setupSideVolumeIndicator()
        self.view.addSubview(volumeView)
    }
    
    func setupSideVolumeIndicator(){
        self.view.addSubview(sideVolumeIndicator)
        sideVolumeIndicator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        sideVolumeIndicator.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        sideVolumeIndicator.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        currentOutputVolume = AVAudioSession.sharedInstance().outputVolume
        let volumeHeightConstant = self.view.frame.height * CGFloat(currentOutputVolume)
        sideVolumeHeightConstraint = sideVolumeIndicator.heightAnchor.constraint(equalToConstant: volumeHeightConstant)
        sideVolumeHeightConstraint.isActive = true
    
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            isDragging = true
        }else if gesture.state == .changed {
            let velocity = gesture.velocity(in: self.view)
            if velocity.y > 0 {
                NotificationCenter.default.post(name: Notification.Name("AVSystemController_SystemVolumeDidChangeNotification"), object: true)
            }else if velocity.y < 0 {
                NotificationCenter.default.post(name: Notification.Name("AVSystemController_SystemVolumeDidChangeNotification"), object: false)
            }
            if sideVolumeHeightConstraint.constant >= self.view.frame.height {
                sideVolumeHeightConstraint.constant = self.view.frame.height
            }else if sideVolumeHeightConstraint.constant <= 0 {
                sideVolumeHeightConstraint.constant = 0
            }
        }else if gesture.state == .ended {
            isDragging = false
        }
    }
    
    func setupCustomMpVolumeView(){
        let volumeView = MPVolumeView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        volumeView.isHidden = true
        view.addSubview(volumeView)
    }
    
    @objc func volumeChanged(notification: NSNotification) {
        guard let volumeView = self.volumeView.subviews.first as? UISlider else {return}
        if let obj = notification.object as? Bool {
            if obj {
                self.sideVolumeHeightConstraint.constant -= 3
            }else {
                self.sideVolumeHeightConstraint.constant += 3
            }
            volumeView.value = Float(self.sideVolumeHeightConstraint.constant / self.view.frame.height)
        }else {
            let volume = notification.userInfo!["AVSystemController_AudioVolumeNotificationParameter"] as! Float
            if isDragging == false {
                self.sideVolumeHeightConstraint.constant = CGFloat(volume) * self.view.frame.height
            }
        }
    }
}
