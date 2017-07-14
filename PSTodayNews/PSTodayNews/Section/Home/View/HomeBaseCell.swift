//
//  HomeBaseCell.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/25.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

typealias CloseClosure = (() -> Void)

class HomeBaseCell: UITableViewCell {

    var closeCloure: CloseClosure? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        layOut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        addSubview(titleLabel)
        addSubview(stickButton)
        addSubview(nameLabel)
        addSubview(commentLabel)
        addSubview(timeLabel)
        addSubview(closeButton)
    }
    
    func layOut() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kHomeMargin)
            make.right.equalTo(-kHomeMargin)
            make.top.equalTo(10)
        }
        stickButton.snp.makeConstraints { (make) in
            make.left.equalTo(kHomeMargin)
            make.width.equalTo(40)
            make.height.equalTo(20)
            make.top.equalTo(titleLabel.snp.bottom)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(stickButton.snp.right).offset(10)
            make.top.equalTo(stickButton)
        }
        commentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(10)
            make.top.equalTo(nameLabel)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(commentLabel.snp.right).offset(10)
            make.top.equalTo(nameLabel)
        }
        closeButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-kHomeMargin)
            make.centerY.equalTo(stickButton)
        }

    }
    
    // 标题
    lazy var titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.black
        return titleLabel
    }()
    
    // 置顶，热，广告，视频
    lazy var stickButton: UIButton = {
       let stickButton = UIButton()
        stickButton.isHidden = true
        stickButton.layer.cornerRadius = 3
        stickButton.sizeToFit()
        stickButton.isUserInteractionEnabled = false
        stickButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        stickButton.setTitleColor(UIColor.red, for: .normal)
        stickButton.layer.borderColor = UIColor.red.cgColor
        stickButton.layer.borderWidth = 0.5
        return stickButton
    }()
    
    // 用户名
    lazy var nameLabel: UILabel = {
       let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.numberOfLines = 0
        nameLabel.textColor = UIColor.lightGray
        return nameLabel
    }()
    
    // 评论
    lazy var commentLabel: UILabel = {
        let commentLabel = UILabel()
        commentLabel.font = UIFont.systemFont(ofSize: 14)
        commentLabel.numberOfLines = 0
        commentLabel.textColor = UIColor.lightGray
        return commentLabel
    }()

    // 时间
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.numberOfLines = 0
        timeLabel.textColor = UIColor.lightGray
        return timeLabel
    }()
    
    // 关闭按钮
    lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(UIImage(named: "add_textpage_17x12_"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return closeButton
    }()
}

extension HomeBaseCell {
    
    func closeAction() {
        
        if closeCloure != nil {
            closeCloure!()
        }
    }
}
