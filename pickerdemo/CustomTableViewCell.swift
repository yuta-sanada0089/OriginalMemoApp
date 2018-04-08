//
//  CustomTableViewCell.swift
//  pickerdemo
//
//  Created by 真田雄太 on 2018/04/08.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    

    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var setsLabel: UILabel!
    
    @IBOutlet weak var event: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var reps: UILabel!
    @IBOutlet weak var sets: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
