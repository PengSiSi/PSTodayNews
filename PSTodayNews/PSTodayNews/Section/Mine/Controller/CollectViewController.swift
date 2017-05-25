//
//  CollectViewController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/25.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

private let kTitleViewH :CGFloat = 40

class CollectViewController: BaseViewController, PageTitleViewDelegate, PageContentViewDelegate {

    let titles = ["我的收藏","阅读历史","推送历史"]
    var isEditFlag: Bool = false
    
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavBarH, width: kScreenW, height: kTitleViewH)
        let titleView = PageTitleView(frame: titleFrame, titles: (self?.titles)!)
        //MARK:- 控制器作为PageTitleViewDelegate代理
        titleView.delegate = self
        return titleView
        }()
    
    fileprivate lazy var pageContentView : PageContentView = { [weak self] in
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavBarH + kTitleViewH, width: kScreenW, height: kScreenH - kStatusBarH - kNavBarH - kTitleViewH)
        var childVcs = [CollectSubViewController]()
        for _ in 0..<(self?.titles.count)! {
            let vc = CollectSubViewController()
//            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            vc.view.backgroundColor = UIColor.white
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        //MARK:- 控制器作为PageContentViewDelegate代理
        contentView.delegate = self
        return contentView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "收藏/历史"
        setNavItem()
        setupUI()
    }
    
    func setupUI() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
}

extension CollectViewController {
    
    func setNavItem() {
        let searchItem = UIBarButtonItem(image: UIImage(named: "search_24x24_"), style: .plain, target: self, action: #selector(searchAction))
        let editButton = UIButton(type: UIButtonType.custom)
        editButton.setTitle("编辑", for: .normal)
        editButton.setTitle("取消", for: .selected)
        editButton.setTitleColor(UIColor.gray, for: .normal)
        editButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        editButton.addTarget(self, action: #selector(editeAction(btn:)), for: .touchUpInside)
        let editItem = UIBarButtonItem(customView: editButton)
//        let editeItem = UIBarButtonItem(title: "编辑", style: .plain, target: self, action: #selector(editeAction))
        self.navigationItem.rightBarButtonItems = [editItem,searchItem]
    }
    
    func searchAction() {
        
        let searchVc = VideoSearchViewController()
        self.navigationController?.pushViewController(searchVc, animated: true)
    }
    
    func editeAction(btn: UIButton) {
        
        btn.isSelected = !btn.isSelected
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "EditButtonClick"), object: nil, userInfo: ["isEditFlag": btn.isSelected])
    }
}

extension CollectViewController {
    
    
    //MARK:- PageTitleViewDelegate代理实现
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
    
    //MARK:- PageContentViewDelegate代理实现
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
