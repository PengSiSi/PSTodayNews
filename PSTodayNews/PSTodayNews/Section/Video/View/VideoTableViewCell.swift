//
//  VideoTableViewCell.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/7/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import Kingfisher

@objc
// 点击视频播放
protocol VideoTableViewCellProtocol: NSObjectProtocol {
    func VideoPlayClick(cell: VideoTableViewCell, model: VideoModel)
}

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avaterImgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var desLabel: UILabel!
    
    @IBOutlet weak var picImgView: UIImageView!
    // 播放按钮
    lazy var playBtn: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    // 点击视频播放按钮的代理
    weak var delegate: VideoTableViewCellProtocol?
    var model: VideoModel? {
        didSet {
            self.picImgView.kf.setImage(with: URL(string: (model?.coverForFeed)!)!, placeholder: UIImage(named: "10"))
            self.titleLabel.text = model?.title ?? "思思"
            self.desLabel.text = model?.videoDescription ?? "思思棒棒哒"
            timeLabel.text = timeStamp(timeStr:  Double(model!.date!))
            self.avaterImgView.kf.setImage(with: URL(string: (model?.coverForFeed)!)!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        avaterImgView.layer.cornerRadius = 28;
        avaterImgView.layer.masksToBounds = true
        // 添加触摸
        self.picImgView.isUserInteractionEnabled = true
        // 这样设置可以防止播放视频的时候还需要隐藏播放按钮
        self.playBtn.setImage(UIImage(named: "playicon_video_60x60_"), for: .normal)
        self.playBtn.addTarget(self, action: #selector(play(sender:)), for: .touchUpInside)
        self.picImgView.addSubview(self.playBtn)
        contentView.systemLayoutSizeFitting(UILayoutFittingExpandedSize)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.playBtn.center = CGPoint(x: kScreenW / 2, y: picImgView.height / 2)
    }
    
    // MARK: - Date的扩展
    /**
     时间戳转化为字符串
     time:时间戳字符串
     */
    func timeStamp(timeStr: Double) -> String {
        //        let time = Double(timeStr)!  + 28800  //因为时差问题要加8小时 == 28800 sec
        
        //        let time: TimeInterval = 1000
        let detaildate = Date(timeIntervalSince1970: timeStr/1000.0)
        
        //实例化一个NSDateFormatter对象
        let dateFormatter = DateFormatter()
        
        //设定时间格式,这里可以设置成自己需要的格式
        dateFormatter.dateFormat = "yyyy-MM-dd HH:MM:ss"
        
        let currentDateStr = dateFormatter.string(from: detaildate)
        return currentDateStr
    }
    
    func play(sender: UIButton) {
        if (delegate?.responds(to: #selector(VideoTableViewCellProtocol.VideoPlayClick(cell:model:))))! {
            delegate?.VideoPlayClick(cell: self, model: model!)
        }
    }
}
