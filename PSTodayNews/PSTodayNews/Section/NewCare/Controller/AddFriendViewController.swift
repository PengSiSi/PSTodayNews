//
//  AddFriendViewController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/24.
//  Copyright © 2017年 思 彭. All rights reserved.

// 添加朋友页面

import UIKit

class AddFriendViewController: BaseViewController {

    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        setupUI()
    }
}

extension AddFriendViewController {
    
    func initialize() {
        self.navigationItem.title = "添加好友"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "告诉朋友", style: .plain, target: self, action: #selector(tellFriendAction))
    }
    
    func setupUI() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView?.rowHeight = 58
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
        // 注册cell
        tableView?.register(UINib(nibName: "AddFriendCell", bundle: nil), forCellReuseIdentifier: "addFriendCell")
        tableView?.tableFooterView = UIView()
        tableView?.tableHeaderView = setupTableHeaderView()
    }
    
    func setupTableHeaderView() -> UIImageView {
        
        let headerImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: k_ScreenWidth, height: 100))
        headerImgView.backgroundColor = UIColor.green
        return headerImgView
    }
}

extension AddFriendViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addFriendCell", for: indexPath) as! AddFriendCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "值得关注"
    }
}

extension AddFriendViewController {
    
    func tellFriendAction() {
        let tellFriendVc = TellFriendViewController()
        self.navigationController?.pushViewController(tellFriendVc, animated: true)
    }
}
