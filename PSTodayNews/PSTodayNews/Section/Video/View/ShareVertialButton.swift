//
//  ShareVertialButton.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/24.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class ShareVertialButton: UIButton {

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
        imageView?.y = 0
        imageView?.width = 60
        imageView?.height = 60
        // 调整文字
        titleLabel?.x = 0
        titleLabel?.y = imageView!.height + 7
        titleLabel?.width = self.width
        titleLabel?.height = self.height - self.titleLabel!.y
    }

}
