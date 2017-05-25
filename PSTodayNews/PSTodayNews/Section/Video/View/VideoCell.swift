//
//  VideoCell.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/23.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {

    var moreButtonClickClosure: (() -> ())?

    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    // 播放
    @IBAction func playButtonClick(_ sender: Any) {
        
    }
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var avaterImgView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    // 评论
    @IBAction func commentButton(_ sender: Any) {
        
    }
    // 更多
    @IBAction func moreButtonClick(_ sender: Any) {
        
        if self.moreButtonClickClosure != nil {
            moreButtonClickClosure!()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
