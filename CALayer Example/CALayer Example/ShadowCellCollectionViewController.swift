//
//  ShadowCellCollectionViewController.swift
//  CALayer Example
//
//  Created by 이동건 on 20/09/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ShadowCellCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.contentView.layer.backgroundColor = UIColor.gray.cgColor
        cell.contentView.layer.borderWidth = 2
        cell.contentView.layer.backgroundColor = UIColor.darkGray.cgColor
        cell.contentView.layer.cornerRadius = 20
        
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        cell.contentView.layer.shadowOpacity = 0.7
        cell.contentView.layer.shadowRadius = 10
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(label)
        label.text = "Title"
        label.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        return cell
    }
}

extension ShadowCellCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - 60) / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
