//
//  MainTabBarController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/22.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        addChildViewControllers()
    }
    
    func initialize() {
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = UIColor.init(111, 111, 111, 1.0)
    }
}

extension MainTabBarController {
    
    /// 添加子控制器
    func addChildViewControllers() {
        addChildViewController(childController: HomeViewController(), title: "首页", imageName: "home_tabbar_22x22_", selectedImageName: "home_tabbar_press_22x22_")
        addChildViewController(childController: VideoViewController(), title: "视频", imageName: "video_tabbar_22x22_", selectedImageName: "video_tabbar_press_22x22_")
        addChildViewController(childController: NewCareViewController(), title: "微头条", imageName: "newcare_tabbar_22x22_", selectedImageName: "newcare_tabbar_press_22x22_")
        addChildViewController(childController: MineViewController(), title: "我的", imageName: "mine_tabbar_22x22_", selectedImageName: "mine_tabbar_press_22x22_")
    }
    
    func addChildViewController(childController: UIViewController, title: String, imageName: String, selectedImageName: String) {
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        let nav = BaseNavigationController(rootViewController: childController)
        addChildViewController(nav)
    }
}
