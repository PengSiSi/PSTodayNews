//
//  NewCareViewController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/22.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

let tableViewCellID = "cell"

class NewCareViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView?
    var dataArr = ["1:实现时间线", "2:push底部出现Tab"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "follow_title_profile_18x18_"), style: .plain, target: self, action: #selector(addFriendAction))
        setupUI()
    }
    
    func setupUI() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
        // 注册cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellID)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID, for: indexPath)
        cell.textLabel?.text = dataArr[indexPath.row];
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(TimeLineViewController(), animated: true)
        }
        if indexPath.row == 1 {
            self.navigationController?.pushViewController(TabBarViewController(), animated: true)
        }
    }
}


extension NewCareViewController {
    
    func addFriendAction() {
        let addFriendVc = AddFriendViewController()
        self.navigationController?.pushViewController(addFriendVc, animated: true)
    }
}
