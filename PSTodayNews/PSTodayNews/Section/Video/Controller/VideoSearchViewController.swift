//
//  VideoSearchViewController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/23.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class VideoSearchViewController: BaseViewController,UISearchBarDelegate {

    // 视图消失
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 先searchBar消失
        searchBar.resignFirstResponder()
    }
    
    // 视图出现
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - 懒加载
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "请输入关键字"
        searchBar.delegate = self
        searchBar.barStyle = .blackOpaque
        return searchBar
    }()
}

// MARK: - 设置界面

extension VideoSearchViewController {
    
    func setupUI() {
        self.view.backgroundColor = GlobalColor()
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
//        navigationItem.leftBarButtonItem = UIBarButtonItem()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancleAction))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.init(37, 142, 240, 1.0)
    }
}

extension VideoSearchViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
}

extension VideoSearchViewController {
    
    func cancleAction() {
        print("取消..")
        searchBar.resignFirstResponder()
        navigationController?.popViewController(animated: true)
    }
}

extension VideoSearchViewController {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("搜索")
    }
}
