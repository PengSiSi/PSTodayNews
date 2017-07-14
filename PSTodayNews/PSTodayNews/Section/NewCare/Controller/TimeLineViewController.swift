//
//  TimeLineViewController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/7/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

let cellID = "cell"

class TimeLineViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "时间线Demo"
        setupUI()
    }
    
    func setupUI() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
//        tableView?.estimatedRowHeight = 80  // 设置估算高度
//        tableView?.rowHeight = UITableViewAutomaticDimension // 告诉tableView我们cell的高度是自动的
        tableView?.rowHeight = 120
        view.addSubview(tableView!)
        tableView?.separatorStyle = .none
        // 注册cell
        tableView?.register(TimeLineCell.self, forCellReuseIdentifier: cellID)
        tableView?.contentInset = UIEdgeInsetsMake(10, 0, 0, 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TimeLineCell
        cell.selectionStyle = .none
        cell.indexPath = indexPath
        return cell
    }
}
