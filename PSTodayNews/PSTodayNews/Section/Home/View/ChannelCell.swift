
//
//  ChannelCell.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/24.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class ChannelCell: UICollectionViewCell {
    
    var edite: Bool? {
        didSet {
            imageView.isHidden = edite!
        }
    }
    var text: String? {
        didSet {
            label.text = text
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var label: UILabel = {
        let label = UILabel(frame: self.bounds)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var imageView: UIImageView = {
        
        let image = UIImageView(frame: CGRect(x: self.right - 12, y: 2, width: 10, height: 10))
        image.image = UIImage(named: "add_channels_close_small_press_night_14x14_")
        image.isHidden = true
        return image
    }()
}

// 设置界面

extension ChannelCell {
    
    func setupSubViews() {
        
        contentView.addSubview(label)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView)
            make.right.equalTo(self.contentView)
        }
    }
    
    func layOut() {
        
    }
}
