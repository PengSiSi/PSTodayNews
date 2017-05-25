//
//  MenuTitleView.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/23.
//  Copyright © 2017年 思 彭. All rights reserved.

// 首页标题头view

import UIKit
import SnapKit

protocol MenuTitleViewDelegate: NSObjectProtocol {
    
    // 点击标题
    func menuTitle(menuTitleView: MenuTitleView, didSelectMenuTitleLabel titleLabel: TitleLabel)
    
    // 点击搜索按钮
    func menuTitle(menuTitleView: MenuTitleView, didSelectSearchButton searchButton: UIButton)
}

class MenuTitleView: UIView {
    
    weak var delegate: MenuTitleViewDelegate?
    // 顶部标题数组
    var titles = [VideoTopTitle]()
    // 存放标题label数组
    var labels = [TitleLabel]()
    // 存放label的宽度
    fileprivate var labelWidth = [CGFloat]()
    // 向外界传递 titles 数组
    var videoTitlesClosure: ((_ titleArray: [VideoTopTitle])->())?
    // 记录当前选中的下标
     var currentIndex: Int = 0
    // 记录上一个下标
     var oldIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 请求数据
        loadTitleData()
        // 拿到数据再创建label
//        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载
    lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var searchButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "search_topic_24x24_"), for: .normal)
        // 注意self使用当前类.self
        button.addTarget(self, action: #selector(searchButtonClick(button:)), for: .touchUpInside)
        return button
    }()
}

// MARK: - 设置界面
extension MenuTitleView {
    
    func setupUI() {
        addSubview(scrollView)
        addSubview(searchButton)
        // 布局视图
        scrollView.snp.makeConstraints { (make) in
            make.left.bottom.top.equalTo(self)
            make.right.equalTo(searchButton.snp.left)
        }
        searchButton.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self)
            make.width.equalTo(30)
        }
        // 添加label
        setupTitlelabels()
        setupLabelsPosition()
        
        // 传递数据
        videoTitlesClosure?(titles)
    }
    
    func setupTitlelabels() {
        for (index, topic) in titles.enumerated() {
            let label = TitleLabel()
            let topicModel: VideoTopTitle = topic
            label.text = topicModel.name
            label.tag = index
            label.textColor = UIColor.black
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
            // 添加手势
            let tap = UITapGestureRecognizer(target: self, action: #selector(labelClick(tap:)))
            label.addGestureRecognizer(tap)
            label.sizeToFit()
            label.font = UIFont.systemFont(ofSize: 17)
            label.width += kMargin
            labels.append(label)
            labelWidth.append(label.width)
            scrollView.addSubview(label)
        }
        let currentLabel = labels[currentIndex]
        currentLabel.textColor = UIColor.red
        currentLabel.currentScale = 1.1
    }
    
    // 设置label的位置
    func setupLabelsPosition() {
        
        var titleX: CGFloat = 0.0
        let titleY: CGFloat = 0.0
        var titleW: CGFloat = 0.0
        let titleH = self.height
        for (index, label) in labels.enumerated() {
            titleW = labelWidth[index]
            titleX = kMargin
            if index != 0 {
                let lastLabel = labels[index - 1]
                titleX = lastLabel.right + kMargin
            }
            label.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
        }
        /// 设置 contentSize
        if let lastLabel = labels.last {
            scrollView.contentSize = CGSize(width: lastLabel.right, height: 0)
        }
    }
    
    // 暴露给外界，向外界传递 topic 数组
    func VideoTitleArrayClosure(closure: @escaping (_ titleArray: [VideoTopTitle])->()) {
        self.videoTitlesClosure = closure
    }

}

// MARK: - 请求数据

extension MenuTitleView {
    
    func loadTitleData() {
        
        // 添加"推荐"model
//        let dict = ["category": "video", "name": "推荐"]
//        let recommendModel = VideoTopTitle(dict: dict as [String : AnyObject])
//        self.titles.append(recommendModel)
        
        // version_code 表示今日头条的版本号，经过测试 >= 5.6 版本新增了『火山直播』
        // os_version 表示 iOS 的系统版本，经测试 >= 8.0 版本新增了『火山直播』
        let url = BASE_URL + "video_api/get_category/v1/?"
        let params = ["device_id": device_id,
                      "version_code": "5.7.1",
                      "iid": IID,
                      "device_platform": "iphone",
                      "os_version": "9.3.2"]

        HTTPTool.shareInstance.requestData(.GET, URLString: url, parameters: params, success: { (response) in
            print(response)
            let dataArray = response["data"] as! NSArray
            // json转model
            for dict in dataArray {
                let model = VideoTopTitle(dict: dict as! [String : AnyObject])
                // 闭包里面注意要用self.
                self.titles.append(model)
            }
            self.setupUI()
        }) { (error) in
            print(error)
        }
    }
}

// MARK: - Private Action

extension MenuTitleView {
    
    func searchButtonClick(button: UIButton) {
        
        delegate?.menuTitle(menuTitleView: self, didSelectSearchButton: button)
    }
    
    // 标题点击
    func labelClick(tap: UITapGestureRecognizer) {
        
        guard let currentLabel = tap.view as? TitleLabel else {
            return
        }
        // 到这里取到值
        oldIndex = currentIndex
        currentIndex = currentLabel.tag
        let oldLabel = labels[oldIndex]
        oldLabel.textColor = UIColor.black
        oldLabel.currentScale = 1.0
        currentLabel.textColor = UIColor.red
        currentLabel.currentScale = 1.1

        //  改变 label 的位置
        adjustVideoTitleOffSetToCurrentIndex(currentIndex: currentIndex, oldIndex: oldIndex)
        // 代理回调
        delegate?.menuTitle(menuTitleView: self, didSelectMenuTitleLabel: currentLabel)
    }
    
    /// 当点击标题的时候，检查是否需要改变 label 的位置
    func adjustVideoTitleOffSetToCurrentIndex(currentIndex: Int, oldIndex: Int) {
        
        // 避免点击和拖拽标题的颜色冲突
        for label in labels {
            label.textColor = UIColor.black
        }
        guard oldIndex != currentIndex else {
            return
        }
        // 重新设置 label 的状态
        let currentLabel = labels[currentIndex]
        let oldLabel = labels[oldIndex]
        currentLabel.currentScale = 1.1
        currentLabel.textColor = UIColor.red
        oldLabel.textColor = UIColor.black
        oldLabel.currentScale = 1.0
        // 当前偏移量
        var offsetX = currentLabel.centerX - SCREENW * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        // 最大偏移量
        var maxOffsetX = scrollView.contentSize.width - (k_ScreenWidth - searchButton.width)
        
        if maxOffsetX < 0 {
            maxOffsetX = 0
        }
        
        if offsetX > maxOffsetX {
            offsetX = maxOffsetX
        }
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    // 重写 frame
    override var frame: CGRect {
        didSet {
            let newFrame = CGRect(x: 0, y: 0, width: k_ScreenWidth, height: 44)
            super.frame = newFrame
        }
    }
}
