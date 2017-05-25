//
//  BaseNavigationController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/22.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize() {
        
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = UIColor.white
        navBar.tintColor = UIColor.init(0, 0, 0, 0.7)
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 17)]
    }
    
    // push
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "lefterbackicon_titlebar_28x28_"), style: .plain, target: self, action: #selector(back))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    // back
    func back() {
        self.popViewController(animated: true)
    }
}
