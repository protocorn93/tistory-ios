//
//  CollectionCell.swift
//  CollectionView + UILongPressGestureRecognizer
//
//  Created by 이동건 on 2018. 3. 21..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel! {
        didSet{
            self.label.textColor = .white
        }
    }
    
    var text:String? {
        didSet{
            self.label.text = text
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        label.text = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }

}
