//
//  VideoCell.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/23.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import Kingfisher

@objc
// 点击视频播放
protocol VideoCellProtocol: NSObjectProtocol {
    func playVideoClick(cell: VideoCell, model: VideoModel)
}

class VideoCell: UITableViewCell {

    var moreButtonClickClosure: (() -> ())?
    // 点击视频播放按钮的代理
    weak var delegate: VideoCellProtocol?
    

    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var model: VideoModel? {
        didSet {
           self.bgImgView.kf.setImage(with: URL(string: (model?.coverForFeed)!)!, placeholder: UIImage(named: "10"))
            self.titleLabel.text = model?.title ?? "电影标题"
            self.nickNameLabel.text = "思思"
            self.avaterImgView.kf.setImage(with: URL(string: (model?.coverForFeed)!)!)
        }
    }
    
    // 播放
    @IBAction func playButtonClick(_ sender: Any) {
        if (delegate?.responds(to: #selector(VideoCellProtocol.playVideoClick(cell:model:))))! {
            delegate?.playVideoClick(cell: self, model: model!)
        }
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
