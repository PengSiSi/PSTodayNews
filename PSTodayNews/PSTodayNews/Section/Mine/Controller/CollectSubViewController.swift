//
//  CollectSubViewController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/25.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit


class CollectSubViewController: BaseViewController {

    let cellID = "tableViewCell"
    var tableView: UITableView?
    var dataArray: Array<Any>?
    
    lazy var bottomView: CollectBottomDeleteView = {
        
        let bottomView = CollectBottomDeleteView(frame: CGRect(x: 0, y: k_ScreenHeight - 44, width: k_ScreenWidth, height: 44))
        bottomView.backgroundColor = UIColor.red
        return bottomView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.automaticallyAdjustsScrollViewInsets = false
        setupUI()
        receiveNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - 通知

extension CollectSubViewController {
    
    func receiveNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(exchageEditStatus(not:)), name: NSNotification.Name(rawValue: "EditButtonClick"), object: nil)
    }
    func exchageEditStatus(not: Notification) {
        
        let isEditFlag = not.userInfo?["isEditFlag"] as! Bool
        if isEditFlag == true {
            tableView?.isEditing = true
            tableView?.allowsMultipleSelection = true
            tableView?.frame = CGRect(x: 0, y: 0, width: k_ScreenWidth, height: k_ScreenHeight - 44)
            view.addSubview(bottomView)
            bottomView.allDeleteClosure = {
                print("一键删除")
            }
            bottomView.deleteClosure = {
                print("删除")
            }
        } else {
            tableView?.isEditing = false
            tableView?.frame = CGRect(x: 0, y: 0, width: k_ScreenWidth, height: k_ScreenHeight)
            bottomView.removeFromSuperview()
        }
    }
}

// MARK: - 代理

extension CollectSubViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupUI() {
        
        let boView = UIView(frame: CGRect(x: 0, y: k_ScreenHeight - 44, width: k_ScreenWidth, height: 44))
        boView.backgroundColor = UIColor.red
        view.addSubview(boView)
        view.bringSubview(toFront: boView)
        view.addSubview(bottomView)
        view.backgroundColor = GlobalColor()
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: k_ScreenWidth, height: k_ScreenHeight - 44 - 40 - 64), style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = 60
        // 可以编辑 后面实现
//        tableView?.isEditing = true
        tableView?.allowsMultipleSelection = true
        view.addSubview(tableView!)
        // 注册cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = "思思"
//        cell.tintColor = UIColor.red
        let view = UIView()
        view.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = view
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle(rawValue: UITableViewCellEditingStyle.insert.rawValue | UITableViewCellEditingStyle.delete.rawValue)!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let cell = tableView.cellForRow(at: indexPath)
//        cell?.selectionStyle = .none 这么设置则cell不能取消选择了
        let subViews: [AnyObject] = (tableView.cellForRow(at: indexPath)?.subviews)!
        for subCell in subViews {
            if subCell.isKind(of: UIControl.self) {
                for circleImage in subCell.subviews {
                    let circleImage: UIImageView = circleImage as! UIImageView
                    circleImage.image = UIImage(named: "air_download_option_press_20x20_")
                }
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)
//        cell?.selectionStyle = .default
//    }
}
