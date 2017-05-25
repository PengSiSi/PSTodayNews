//
//  SettingNotificationCell.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/24.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class SettingNotificationCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var onSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
