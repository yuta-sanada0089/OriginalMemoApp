//
//  CustomTableViewCell.swift
//  pickerdemo
//
//  Created by 真田雄太 on 2018/04/11.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    

    @IBOutlet weak var eventLB: UILabel!
    @IBOutlet weak var weightLB: UILabel!
    @IBOutlet weak var repsLB: UILabel!
    @IBOutlet weak var setsLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
