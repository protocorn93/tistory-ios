//
//  CustomCell.swift
//  tistory_custom_tableview_posting_example
//
//  Created by 이동건 on 2017. 10. 9..
//  Copyright © 2017년 이동건. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    
    @IBOutlet weak var weatherImgView: UIImageView!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
