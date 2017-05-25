//
//  MineCell.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/22.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class MineCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var arrowImgView: UIImageView!
    
    @IBOutlet weak var lineView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var cellModel: MineCellModel? {
        
        didSet {
            self.titleLabel.text = cellModel?.subtitle
            self.tipLabel.text = cellModel?.title
            self.lineView.isHidden = (cellModel?.isHiddenLine!)!
            self.titleLabel.isHidden = (cellModel?.isHiddenSubtitle!)!
        }
    }
    
    override func didMoveToWindow() {
        
    }
}
