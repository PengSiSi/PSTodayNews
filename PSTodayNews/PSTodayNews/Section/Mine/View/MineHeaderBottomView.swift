//
//  MineHeaderBottomView.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/22.
//  Copyright © 2017年 思 彭. All rights reserved.

//  我的界面 -> 头部 view -> 底部白色 view(包含三个按钮)

import UIKit
import SnapKit

class MineHeaderBottomView: UIView {
    
    // 收藏按钮的回调 注意回调可选类型
    var collectinButtonClosure: ((_ collectionButton: UIButton) -> ())?
    var nightnButtonClosure: ((_ nightnButton: UIButton) -> ())?
    var settingButtonClosure: ((_ settingButton: UIButton) -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(collectionButton)
        addSubview(nightButton)
        addSubview(settingButton)
        layOut()
    }
    
    func layOut() {
        
        let margin = (k_ScreenWidth - (3 * 70)) / 6
        collectionButton.snp.makeConstraints { (make) in
            make.width.equalTo(70)
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(margin)
            make.right.lessThanOrEqualTo(nightButton).offset(-kMargin)
        }
        nightButton.snp.makeConstraints { (make) in
            make.width.equalTo(70)
            make.top.bottom.equalTo(self)
            make.left.equalTo(self.collectionButton.snp.right).offset(2 * margin)
        }
        settingButton.snp.makeConstraints { (make) in
            make.width.equalTo(70)
            make.top.bottom.equalTo(self)
            make.right.equalTo(self).offset(-margin)
            make.right.greaterThanOrEqualTo(nightButton).offset(kMargin)
        }
    }
    
    /// 懒加载，创建收藏按钮
    private lazy var collectionButton: VerticalButton = {
        let collectionButton = VerticalButton()
        collectionButton.setTitle("收 藏", for: .normal)
        collectionButton.setTitleColor(UIColor.black, for: .normal)
        collectionButton.addTarget(self, action: #selector(collectionBtnClick(button:)), for: .touchUpInside)
        collectionButton.setImage(UIImage(named: "favoriteicon_profile_24x24_"), for: .normal)
        collectionButton.setImage(UIImage(named: "favoriteicon_profile_press_24x24_"), for: .highlighted)
        collectionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return collectionButton
    }()
    
    /// 懒加载，创建夜间按钮
    private lazy var nightButton: VerticalButton = {
        let nightButton = VerticalButton()
        nightButton.setTitle("夜 间", for: .normal)
        nightButton.setTitleColor(UIColor.black, for: .normal)
        nightButton.addTarget(self, action: #selector(nightBtnClick(button:)), for: .touchUpInside)
        nightButton.setImage(UIImage(named: "nighticon_profile_24x24_"), for: .normal)
        
        nightButton.setImage(UIImage(named: "nighticon_profile_press_24x24_"), for: .highlighted)
        nightButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return nightButton
    }()
    
    /// 懒加载，创建设置按钮
    private lazy var settingButton: VerticalButton = {
        let settingButton = VerticalButton()
        settingButton.setTitle("设 置", for: .normal)
        settingButton.setTitleColor(UIColor.black, for: .normal)
        settingButton.setImage(UIImage(named: "setupicon_profile_24x24_"), for: .normal)
        
        settingButton.setImage(UIImage(named: "setupicon_profile_press_24x24_"), for: .highlighted)
        settingButton.addTarget(self, action: #selector(settingBtnClick(button:)), for: .touchUpInside)
        settingButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return settingButton
    }()
}

extension MineHeaderBottomView {
    
    func collectionBtnClick(button: VerticalButton) {
//        collectionBtnClick(button: button)
        //  通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "collectionBtnClick"), object: nil, userInfo: nil)
    }
    
    func nightBtnClick(button: VerticalButton) {
        nightBtnClick(button: button)
    }
    
    func settingBtnClick(button: VerticalButton) {
        settingBtnClick(button: button)
    }
}
