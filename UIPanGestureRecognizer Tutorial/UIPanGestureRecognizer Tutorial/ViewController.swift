//
//  ViewController.swift
//  UIPanGestureRecognizer Tutorial
//
//  Created by 이동건 on 2018. 6. 8..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fileImageView: UIImageView!
    @IBOutlet weak var trashCanImageView: UIImageView!
    
    private var fileImageOriginCenter: CGPoint?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        fileImageOriginCenter = fileImageView.center
    }
    
    fileprivate func setupGestures(){
        fileImageView.isUserInteractionEnabled = true
        fileImageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let status = gesture.state
        
        switch status {
        case .began,.changed:
//            let location = gesture.location(in: self.view)
//            fileImageView.center.x = location.x
//            fileImageView.center.y = location.y
            let translation = gesture.translation(in: view)
            fileImageView.center.x += translation.x
            fileImageView.center.y += translation.y
            gesture.setTranslation(.zero, in: view)
        case .ended :
            /*
            let fileCenterX = fileImageView.center.x
            let fileCenterY = fileImageView.center.y
            let trashMinX = trashCanImageView.frame.minX
            let trashMaxX = trashCanImageView.frame.maxX
            let trashMinY = trashCanImageView.frame.minY
            let trashMaxY = trashCanImageView.frame.maxY
 
            if fileCenterX >= trashMinX && fileCenterX <= trashMaxX && fileCenterY >= trashMinY && fileCenterY <= trashMaxY {
                UIView.animate(withDuration: 0.5) {
                    self.fileImageView.alpha = 0
                    self.fileImageView.removeFromSuperview()
                }
            }else{
                if let fileImageOriginCenter = fileImageOriginCenter {
                    fileImageView.center = fileImageOriginCenter
                }
            }
            */
            
            if fileImageView.frame.intersects(trashCanImageView.frame) {
                UIView.animate(withDuration: 0.5) {
                    self.fileImageView.alpha = 0
                    self.fileImageView.removeFromSuperview()
                }
            }else{
                if let fileImageOriginCenter = fileImageOriginCenter {
                    UIView.animate(withDuration: 0.5) {
                        self.fileImageView.center = fileImageOriginCenter
                    }
                }
            }
        default:
            break
        }
    }
}

