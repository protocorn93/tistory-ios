//
//  ViewController.swift
//  Auto Sizing UITextview
//
//  Created by 이동건 on 2018. 1. 24..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textView = UITextView()
        textView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        textView.backgroundColor = .lightGray
        view.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false // for auto layout
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        textView.font = UIFont.preferredFont(forTextStyle: .largeTitle) // fontSize
        textView.delegate = self
        textView.isScrollEnabled = false
        
        textViewDidChange(textView)
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
