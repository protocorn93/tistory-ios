//
//  MainVC.swift
//  CollectionView + UILongPressGestureRecognizer
//
//  Created by 이동건 on 2018. 3. 21..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class MainVC: UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    let cellId = "CellID"
    
    var items:[String] = ["one", "two", "three", "four", "five"]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(gesture:))))
        collectionView.register(UINib(nibName: CollectionCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: CollectionCell.reusableIdentifier)
    }
    
    @objc func handleLongPressGesture(gesture: UIGestureRecognizer){
        let location = gesture.location(in: self.collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: location) else {return}
        let item = items[indexPath.row]
        
        let alert = UIAlertController(title: nil, message: "Remove \(item)", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
            self.items.remove(at: indexPath.item)
            self.collectionView.deleteItems(at: [indexPath])
            self.collectionView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.reusableIdentifier, for: indexPath) as! CollectionCell
        cell.text = items[indexPath.row]
        
        cell.backgroundColor = .darkGray
        return cell
    }
}

extension MainVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 16*3) / 2
        return CGSize(width: width, height: width)
    }
}
