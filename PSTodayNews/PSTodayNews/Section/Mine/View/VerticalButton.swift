//
//  VerticalButton.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/22.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class VerticalButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 调整图片
        imageView?.centerX = self.width * 0.5
        imageView?.y = kMargin
        imageView?.width = 24
        imageView?.height = (imageView?.width)!
        
        // 调整文字
        titleLabel?.x = 0
        titleLabel?.y = (imageView?.height)!
        titleLabel?.width = self.width
        titleLabel?.height = self.height - (titleLabel?.y)!
    }
}
