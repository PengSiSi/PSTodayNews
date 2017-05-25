//
//  VideoViewController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/22.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit


class VideoViewController: BaseViewController, UIScrollViewDelegate {
    
    // 当前选中的 titleLabel 的 上一个 titleLabel
    var oldIndex: Int = 0
    var menuView: MenuTitleView?
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        // 注意设置透明,否则不能显示出来
        self.navigationController?.navigationBar.isTranslucent = false
        let menuView = MenuTitleView(frame: CGRect(x: 0, y:0, width: k_ScreenWidth, height: 44))
        self.menuView = menuView
        menuView.delegate = self
        self.view.addSubview(menuView)
        self.view.addSubview(scrollView)

        menuView.VideoTitleArrayClosure {[weak self](titleArray) in
            
            for videoTopTitle in titleArray {
                let videoSubVc = VideoSubViewController()
                videoSubVc.view.backgroundColor = UIColor.randomColor()
                videoSubVc.title = videoTopTitle.name
                self?.addChildViewController(videoSubVc)
//                self?.childViewControllers.append(videoSubVc)
            }
        self?.scrollViewDidEndScrollingAnimation((self?.scrollView)!)
            // 注意强转不要加()
            self?.scrollView.contentSize = CGSize(width: CGFloat(titleArray.count) * k_ScreenWidth, height: k_ScreenHeight)
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 44, width: k_ScreenWidth, height: k_ScreenHeight - 44)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        // 当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        // 取出子控制器
        let vc = childViewControllers[index]
        vc.view.x = scrollView.contentOffset.x
        vc.view.y = 0
        vc.view.height = scrollView.height
        scrollView.addSubview(vc.view)
    }
    
    // scrollView 刚开始滑动时
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 当前索引  这里写了会造成重复选中标题
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        // 记录刚开始拖拽是的 index
        self.oldIndex = index
    }
    
    // scrollView 结束滑动
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        // 当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        // 与刚开始拖拽时的 index 进行比较
        // 检查是否需要改变 label 的位置
        menuView?.adjustVideoTitleOffSetToCurrentIndex(currentIndex: index, oldIndex: self.oldIndex)
    }
}

extension VideoViewController: MenuTitleViewDelegate {
    
    // 搜索
    func menuTitle(menuTitleView: MenuTitleView, didSelectSearchButton searchButton: UIButton) {
        print("search")
        let videoSearchVc = VideoSearchViewController()
        self.navigationController?.pushViewController(videoSearchVc, animated: true)
    }
    
    // 点击标题
    func menuTitle(menuTitleView: MenuTitleView, didSelectMenuTitleLabel titleLabel: TitleLabel) {
        
        var offSet = self.scrollView.contentOffset
        offSet.x = CGFloat(titleLabel.tag) * self.scrollView.width
        self.scrollView.setContentOffset(offSet, animated: true)
    }
}
