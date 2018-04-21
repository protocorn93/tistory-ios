//
//  CollectionCell.swift
//  ExpandingTableView
//
//  Created by 이동건 on 2018. 4. 21..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class CollectionCell: UITableViewCell {
    //MARK: Properties
    var activityCollectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    //MARK: Setup CollectionView
    fileprivate func setupCollectionView(){
        self.addSubview(activityCollectionView)
        activityCollectionView.delegate = self
        activityCollectionView.dataSource = self
        activityCollectionView.register(UINib(nibName: ActivityCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ActivityCell.reuseIdentifier)
        activityCollectionView.backgroundColor = .white
        activityCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        activityCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        activityCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        activityCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        // default
        activityCollectionView.alpha = 0
        activityCollectionView.isHidden = true
    }
}
//MARK:- UICollectionViewDelegate & DataSource
extension CollectionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCell.reuseIdentifier, for: indexPath) as! ActivityCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}
//MARK:- UICollectionViewDelegateFlowLayout
extension CollectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let constant = 100
        return CGSize(width:  constant, height: constant)
    }
    // items inset
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    //sections inset
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
