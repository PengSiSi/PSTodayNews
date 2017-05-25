//
//  ChannelHeaderView.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/24.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class ChannelHeaderView: UICollectionReusableView {
    
    var clickCallBack: (() -> ())?
    var text: String? {
        didSet {
            label.text = text
        }
    }
    var subTitle: String? {
        didSet {
            subTitleLabel.text = subTitle
        }
    }
    
    // 标题
    lazy var label: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // subTitle
    lazy var subTitleLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    // 按钮
    lazy var button: UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.layer.cornerRadius = 3
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.borderWidth = 0.5
        btn.setTitle("编辑", for: .normal)
        btn.setTitle("完成", for: .selected)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
        layOut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置界面

extension ChannelHeaderView {
    
    func setupSubViews() {
        addSubview(label)
        addSubview(subTitleLabel)
        addSubview(button)
    }
    
    func layOut() {
        label.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
        }
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(label.snp.right).offset(10)
            make.centerY.equalTo(label)
        }
        button.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-30)
            make.centerY.equalTo(subTitleLabel)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
    }
}

// MARK: - Private Action

extension ChannelHeaderView {
    
    func buttonClick(button: UIButton) {
        button.isSelected = !button.isSelected
        if clickCallBack != nil {
            clickCallBack!()
        }
    }
}
