//
//  RestaurantTableViewCellTableViewCell.swift
//  RestaurantMemo
//
//  Created by ChengLu on 2021/6/29.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet var cellnumber: UILabel!
    @IBOutlet var cellName: UILabel!
    @IBOutlet var cellAdd: UILabel!
    @IBOutlet var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

