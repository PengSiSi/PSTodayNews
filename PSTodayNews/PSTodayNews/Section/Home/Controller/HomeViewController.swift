//
//  HomeViewController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/22.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, UIScrollViewDelegate {
    
    // 当前选中的 titleLabel 的 上一个 titleLabel
    var oldIndex: Int = 0
    var menuView: MenuScrollView?
    var titleArray = [VideoTopTitle]()
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        //设置badge
        self.tabBarItem.badgeValue = "15"
        loadTitleData()
        // 注意设置透明,否则不能显示出来
        self.navigationController?.navigationBar.isTranslucent = false
        let menuView = MenuScrollView(frame: CGRect(x: 0, y:0, width: k_ScreenWidth, height: 44))
        menuView.backgroundColor = UIColor.lightGray
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

// MARK: - 数据请求

extension HomeViewController {
    
    func loadTitleData() {

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
                self.titleArray.append(model)
            }
            self.menuView?.titlesArray = self.titleArray
        }) { (error) in
            print(error)
        }
    }
}
extension HomeViewController: MenuScrollViewDelegate {
    
    // add
    func menuTitle(menuTitleView: MenuScrollView, didSelectAddButton addButton: UIButton) {
        print("add")
        let addCategoryVc = AddCategoryViewController()
        self.present(addCategoryVc, animated: true, completion: nil)
    }
    
    // 点击标题
    func menuTitle(menuTitleView: MenuScrollView, didSelectMenuTitleLabel titleLabel: TitleLabel) {
        
        var offSet = self.scrollView.contentOffset
        offSet.x = CGFloat(titleLabel.tag) * self.scrollView.width
        self.scrollView.setContentOffset(offSet, animated: true)
    }
}
