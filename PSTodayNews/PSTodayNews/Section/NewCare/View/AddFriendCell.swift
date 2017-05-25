//
//  AddFriendCell.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/24.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class AddFriendCell: UITableViewCell {

    @IBOutlet weak var avaterImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nickNamelabel: UILabel!
    @IBOutlet weak var vipImgView: UIImageView!
    @IBOutlet weak var focusButton: UIButton!
    
    // 关注
    @IBAction func focusDidClick(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        focusButton.layer.cornerRadius = 3
        focusButton.layer.borderWidth = 0.5
        focusButton.layer.borderColor = UIColor.blue.cgColor
        avaterImgView.layer.cornerRadius = 22
    }
}
