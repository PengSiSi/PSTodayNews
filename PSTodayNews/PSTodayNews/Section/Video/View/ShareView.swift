//
//  ShareView.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/23.
//  Copyright © 2017年 思 彭. All rights reserved.

// 分享视图view

import UIKit

typealias ShareItemClosure = (_ shareItemTag: Int, _ title: String) -> Void

class ShareView: UIView {
    
    var shares = [ShareModel]()
    
    // 点击item回调
    var shareClosure:ShareItemClosure? = nil
    
    // 类方法show
    class func show() {
        let shareView = ShareView(frame: UIScreen.main.bounds)
        shareView.backgroundColor = UIColor.init(0, 0, 0, 0.3)
        let window = UIApplication.shared.keyWindow
        window?.addSubview(shareView)
        UIView.animate(withDuration: 0.3, animations: { 
            shareView.bgView.frame = CGRect(x: 0, y: k_ScreenHeight - 290, width: k_ScreenWidth, height: 290)
        }) { (_) in
            shareView.addButton(scrollView: shareView.topScrollView)
            // 延时操作 如果不需要在主线程执行,就去掉main
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
               shareView.addButton(scrollView: shareView.bottomScrollView)
            })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let path = Bundle.main.path(forResource: "YMSharePlist", ofType: ".plist")
        let shareArray = NSArray(contentsOfFile: path!)
        for item in shareArray! {
            
            let shareModel = ShareModel(dict: item as! [String: AnyObject])
            shares.append(shareModel)
        }
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        bgView.frame = CGRect(x: 0, y: k_ScreenHeight, width: k_ScreenWidth, height: k_ScreenHeight - 290)
        addSubview(bgView)
        topScrollView.frame = CGRect(x: 0, y: 0, width: k_ScreenHeight, height: 126)
        bgView.addSubview(topScrollView)
        lineView.frame = CGRect(x: 0, y: topScrollView.bottom, width: k_ScreenWidth, height: 1)
        bgView.addSubview(lineView)
        bottomScrollView.frame = CGRect(x: 0, y: lineView.bottom, width: k_ScreenWidth, height: 126)
        bgView.addSubview(bottomScrollView)
        cancleButton.frame = CGRect(x: 0, y: bottomScrollView.bottom, width: k_ScreenWidth, height: 40)
        bgView.addSubview(cancleButton)
    }
    
    // 背景
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(240, 240, 240, 1.0)
        return bgView
    }()
    //分割线
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(220, 220, 220, 1.0)
        return lineView
    }()
    // 上面scrollView
    lazy var topScrollView: UIScrollView = {
       let scrollView = UIScrollView()
       scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    // 下面的scrollView
    lazy var bottomScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    // 取消按钮
    lazy var cancleButton: UIButton = {
       let button = UIButton()
        button.setTitle("取消", for: .normal)
        button.layer.borderColor = UIColor.init(220, 220, 220, 1.0).cgColor
        button.layer.borderWidth = klineWidth
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(UIColor.black, for: .normal)
        // 注意按钮需要是self
        button.addTarget(self, action: #selector(cancleAction), for: .touchUpInside)
        return button
    }()
}

// MARK: - Private Action

extension ShareView {
    
    // 取消按钮被点击
    func cancleAction() {
        
        UIView.animate(withDuration: 0.3, animations: { 
            self.bgView.frame = CGRect(x: 0, y: k_ScreenHeight, width: k_ScreenWidth, height: 290)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3, animations: {
            self.bgView.frame = CGRect(x: 0, y: k_ScreenHeight, width: k_ScreenWidth, height: 290)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    func addButton(scrollView: UIScrollView) {
        
        let buttonW: CGFloat = 80
        let buttonH: CGFloat = 80
        let buttonY: CGFloat = scrollView.bottom
        for index in 0..<shares.count {
            let share = shares[index]
            let button = ShareVertialButton()
            button.tag = index
            button.setImage(UIImage(named: "\(share.icon!)"), for: .normal)
            button.setTitle("\(share.title!)", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.setTitleColor(UIColor.black, for: .normal)
            button.addTarget(self, action: #selector(shareButtonDidClick(button:)), for: .touchUpInside)
            let buttonX = CGFloat(index) * buttonW + 2 * kMargin
            button.x = buttonX
            button.width = buttonW
            button.height = buttonH
            scrollView.addSubview(button)
            button.y = buttonY
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: UIViewAnimationOptions(rawValue: 0), animations: { 
                button.y = 23
            }, completion: { (_) in
                
            })
            if index == shares.count - 1 {
                scrollView.contentSize = CGSize(width: button.right + 2 * kMargin, height: scrollView.height)
            }
        }
    }
    
    func shareButtonDidClick(button: ShareVertialButton) {
//        if self.shareClosure != nil {
//            self.shareClosure!(button.tag, (button.titleLabel?.text)!)
//        }
    // 通知传递
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ShareItemDidClickNotification"), object: nil, userInfo: ["shareItemTag": button.tag, "shareItemTitle": button.titleLabel?.text ?? ""])
    }
}
