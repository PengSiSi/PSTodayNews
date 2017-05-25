//
//  TellFriendViewController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/24.
//  Copyright © 2017年 思 彭. All rights reserved.

// 告诉好友页面

import UIKit

class TellFriendViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView?.rowHeight = 58
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
        // 注册cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView?.tableFooterView = UIView()
        tableView?.tableHeaderView = UIView()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: "weixinicon_login_40x40_")
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        if indexPath.row == 0 {
            cell.textLabel?.text = "微信告诉好友"
        } else {
            cell.textLabel?.text = "短信告诉好友"
        }
        return cell
    }
}
