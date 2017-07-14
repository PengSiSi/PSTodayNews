//
//  CollectBottomDeleteView.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/25.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import SnapKit

typealias AllDeleteClosure = (() -> Void)
typealias DeleteClosure = (() -> Void)

class CollectBottomDeleteView: UIView {
    
    var allDeleteClosure: AllDeleteClosure? = nil
    var deleteClosure: DeleteClosure? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        layOut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(allDeleteButton)
        self.addSubview(deleteButton)
    }
    
    func layOut() {
        allDeleteButton.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.width.equalTo(100)
            make.height.equalTo(self)
        }
        deleteButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-10)
            make.centerY.equalTo(self)
            make.width.equalTo(50)
            make.height.equalTo(self)
        }
    }
    
    // 懒加载
    lazy var allDeleteButton: UIButton = {
       let button = UIButton()
        button.setTitle("一键清空", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.addTarget(self, action: #selector(allDeleteAction), for: .touchUpInside)
        return button
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("删除", for: .normal)
        button.isSelected = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        return button
    }()
    
    func allDeleteAction() {
        
        if allDeleteClosure != nil {
            allDeleteClosure!()
        }
    }
    
    func deleteAction() {
        
        if deleteClosure != nil {
            deleteClosure!()
        }
    }
}
