//
//  TimeLineCell.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/7/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import SnapKit

class TimeLineCell: UITableViewCell {
    
    var topLineView: UIImageView?
    var iconImgView: UIImageView?
    var bottomLienView: UIImageView?
    var rightBgView: UIImageView?
    var titleLabel: UILabel?
    var timeLabel: UILabel?
    var deslabel: UILabel?
    
    var indexPath: IndexPath? {
        didSet {
            if indexPath?.row == 0 {
                topLineView?.isHidden = true
            }
            if indexPath?.row == 4 {
                bottomLienView?.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSubViews()
        layout()
        testUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubViews() {
        topLineView = UIImageView(image: UIImage(named: "ic_order_shu"))
        iconImgView = UIImageView(image: UIImage(named: "ic_order_status_zhifu"))
        bottomLienView = UIImageView(image: UIImage(named: "ic_order_shu"))
        rightBgView = UIImageView(image: UIImage(named: "ic_order_status_item_bg")?.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 10, 0, 40), resizingMode: .stretch))
        titleLabel = UILabel()
        timeLabel = UILabel()
        deslabel = UILabel()
        contentView.addSubview(topLineView!)
        contentView.addSubview(iconImgView!)
        contentView.addSubview(bottomLienView!)
        contentView.addSubview(rightBgView!)
        contentView.addSubview(titleLabel!)
        contentView.addSubview(timeLabel!)
        contentView.addSubview(deslabel!)
    }
    
    func layout() {
        topLineView?.snp.makeConstraints({ (make) in
            make.left.equalTo(contentView).offset(30)
            make.top.equalTo(contentView).offset(0)
            make.width.equalTo(1)
            make.height.equalTo(30)
        })
        iconImgView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(topLineView!)
            make.top.equalTo((topLineView?.snp.bottom)!)
            make.width.equalTo(30)
            make.height.equalTo(30)
        })
        bottomLienView?.snp.makeConstraints({ (make) in
            make.left.equalTo(contentView).offset(30)
            make.top.equalTo((iconImgView?.snp.bottom)!).offset(0)
            make.width.equalTo(1)
            make.height.equalTo(60)
        })
        rightBgView?.snp.makeConstraints({ (make) in
            make.left.equalTo((iconImgView?.snp.right)!).offset(10)
            make.top.equalTo(iconImgView!).offset(-30)
            make.right.equalTo(contentView).offset(-10)
            make.bottom.equalTo(contentView).offset(-10)
        })
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(rightBgView!).offset(20)
            make.top.equalTo(rightBgView!).offset(10)
            make.height.equalTo(20)
        })
        timeLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((titleLabel?.snp.right)!).offset(10)
            make.top.equalTo(rightBgView!).offset(10)
            make.height.equalTo(25)
            make.right.equalTo(rightBgView!).offset(-10)
        })
        deslabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(titleLabel!)
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(10)
            make.height.equalTo(25)
        })
    }
    
    func testUI() {
        titleLabel?.text = "标题"
        timeLabel?.text = "2017年12月20日"
        deslabel?.text = "开始配送"
    }
}
