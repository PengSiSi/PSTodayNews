//
//  SettingViewController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/24.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

let settingCellID = "SettingTableViewCell"
let settingCell1ID = "SettingNotificationCell"

class SettingViewController: BaseViewController {

    var tableView: UITableView?
    var cellArray: [[String: String]] = [[String: String]]()
    
    var section0Array: [String]? // section0
    var section1Array: [String]? // section1
    var section2Array: [String]? // section2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置"
        initialize()
        setupUI()
    }
    
    func initialize() {
        
        cellArray = [["编辑资料": "",
                      "账号和绑定账号": "",
                      "黑名单": ""],
                     ["清除缓存": "",
                      "字体大小": "",
                      "列表显示摘要": "",
                      "非WiFi网络流量": "",
                      "非WiFi网络播放提醒": "",
                      "推送通知": ""],
                     ["离线下载": "",
                      "头条封面": "",
                      "当前版本": "1.0.1"]
                        ]
        section0Array = ["编辑资料",
                         "账号和绑定账号",
                         "黑名单"]
        section1Array = ["清除缓存",
                         "字体大小",
                         "列表显示摘要",
        "非WiFi网络流量", "非WiFi网络播放提醒", ""]
        section2Array = ["离线下载",
                         "头条封面",
                         "当前版本"]
    }
    
    func setupUI() {
        view.backgroundColor = GlobalColor()
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        let nib = UINib(nibName: "SettingTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: settingCellID)
        let nib1 = UINib(nibName: "SettingNotificationCell", bundle: nil)
        tableView?.register(nib1, forCellReuseIdentifier: settingCell1ID)
        let footerView = UIView()
        footerView.height = kMargin
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.tableFooterView = footerView
        tableView?.rowHeight = kMineCellH
//        tableView?.separatorStyle = .none
        tableView?.tableHeaderView = UIView()
        view.addSubview(tableView!)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
     func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        let sectionArray = cellArray[section]
//        return sectionArray.count
        if section == 0 {
            return 3;
        } else if section == 1 {
            return 6
        } else {
            return 3
        }
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 && indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: settingCell1ID, for: indexPath) as! SettingNotificationCell
            configureSettingNotificationCell(cell: cell, indexPath: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: settingCellID, for: indexPath) as! SettingTableViewCell
            configureSettingCell(cell: cell, indexPath: indexPath)
            cell.selectionStyle = .none  // 取消选中效果
            return cell
        }
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return kMargin
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func configureSettingCell(cell: SettingTableViewCell, indexPath: IndexPath) {
        if indexPath.section == 0 || indexPath.section == 2 && indexPath.row != 2 {
            cell.rightLabel.isHidden = true
            cell.accessoryType = .disclosureIndicator
        }
        if indexPath.section == 1 && indexPath.row == 2 {
            cell.onSwitch.isHidden = false
        }
        if indexPath.section == 0 {
            cell.leftLabel.text = section0Array?[indexPath.row]
        }
        if indexPath.section == 1 {
            cell.leftLabel.text = section1Array?[indexPath.row]
        }
        if indexPath.section == 2 {
            cell.leftLabel.text = section2Array?[indexPath.row]
        }
    }
    
    func configureSettingNotificationCell(cell: SettingNotificationCell, indexPath: IndexPath) {
        
        cell.titleLabel.text = "推送通知"
        cell.onSwitch.isHidden = false
        cell.subTitleLabel.text = "你可能错过重要资讯通知,点击开启"
    }
}

