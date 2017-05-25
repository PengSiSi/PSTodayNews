//
//  MineHeaderIconButton.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/22.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class MineHeaderIconButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
        setTitleColor(UIColor.white, for: .normal)
        imageView?.layer.cornerRadius = 30
        imageView?.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 调整图片
        imageView?.x = 0
        imageView?.y = 0
        imageView?.width = 60
        imageView?.height = imageView!.width
        // 调整文字
        titleLabel?.x = 0
        titleLabel?.y = imageView!.height + kMargin
        titleLabel?.width = self.width
        titleLabel?.height = 2 * kMargin
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
