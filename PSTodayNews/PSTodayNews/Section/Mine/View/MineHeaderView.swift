//
//  MineHeaderView.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/22.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class MineHeaderView: UIView {
    
    // 头像按钮的点击回调
    var headerViewClosure: ((_ iconButton: UIButton) -> ())?
    
    // 类方法创建
    class func headerView() -> MineHeaderView {
        let frame = CGRect(x: 0, y: 0, width: k_ScreenWidth, height: 260)
        return MineHeaderView(frame: frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载
    // 背景
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "hrscy")
        return bgImageView
    }()
    
    // 头像
    lazy var headerPhotoButton: MineHeaderIconButton = {
       let headerPhotoButton = MineHeaderIconButton()
        headerPhotoButton.addTarget(MineHeaderIconButton.self, action: #selector(headPhotoBtnClick(button:)), for: .touchUpInside)
        headerPhotoButton.setTitle("思思", for: .normal)
        headerPhotoButton.setImage(UIImage(named: "dog_65x65_"), for: .normal)
        return headerPhotoButton
    }()
    
    // 底部view
    lazy var bottomView: MineHeaderBottomView = {
       let bottomView = MineHeaderBottomView()
        return bottomView
    }()
}

// MARK: 设置界面

extension MineHeaderView {
    
    func setupUI() {
        
        addSubview(bgImageView)
        addSubview(headerPhotoButton)
        addSubview(bottomView)
        layOut()
    }
    
    func layOut() {
        // 设置约束
        bgImageView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self).offset(-2 * kMargin)
            make.height.equalTo(kYMMineHeaderImageHeight)
        }
        
        headerPhotoButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.centerX)
            make.size.equalTo(CGSize(width: 80, height: 80))
            make.top.equalTo(bgImageView.snp.top).offset(64)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self)
            make.top.equalTo(bgImageView.snp.bottom)
        }
    }
}

// MARK: - Private Action

extension MineHeaderView {
    
    func headPhotoBtnClick(button: MineHeaderIconButton) {
        
    }
}
