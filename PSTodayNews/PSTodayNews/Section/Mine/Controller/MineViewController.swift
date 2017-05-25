//
//  MineViewController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/22.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

let mineCellID = "MineCell"

class MineViewController: UITableViewController {

    // 数据源数组
    var cells = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receiveNotification()
        loadData()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        // 隐藏导航栏的属性写到 `viewDidLoad()` 里不起作用。
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    lazy var headerView: MineHeaderView = {
        
        let headerView = MineHeaderView.headerView()
        return headerView
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - 接收通知

extension MineViewController {
    
    func receiveNotification () {
        
        // 接收收藏通知
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotification(notification:)), name: NSNotification.Name(rawValue: "collectionBtnClick"), object: nil)
    }
    
    func receiveNotification(notification: Notification) {
        
        print("接收通知--收藏按钮被点击")
        let collectVc = CollectViewController()
        self.navigationController?.pushViewController(collectVc, animated: true)
    }
}

// MARK: - 设置界面
extension MineViewController {
    
    func setupUI() {
        view.backgroundColor = GlobalColor()
        let nib = UINib(nibName: "MineCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: mineCellID)
        let footerView = UIView()
        footerView.height = kMargin
        tableView.tableFooterView = footerView
        tableView.rowHeight = kMineCellH
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView
    }
}

// MARK: - 加载数据
extension MineViewController {
    
     func loadData() {
        
        let path = Bundle.main.path(forResource: "YMMineCellPlist", ofType: "plist")
        let plistArray = NSArray.init(contentsOfFile: path!)
        for arrayDict in plistArray! {
            let array = arrayDict as! Array<Any>
            var sections = [AnyObject]()
            for dict in array {
                let cell = MineCellModel(dict: dict as! [String: AnyObject])
                sections.append(cell)
            }
            cells.append(sections as AnyObject)
        }
    }
}

extension MineViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.cells.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let arr = cells[section] as! [MineCellModel]
        return arr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: mineCellID, for: indexPath) as! MineCell
        cell.selectionStyle = .none  // 取消选中效果
        let sections = self.cells[indexPath.section] as! [MineCellModel]
        cell.cellModel = sections[indexPath.row] 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return kMargin
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            switch indexPath.row {
            case 6:
                self.navigationController?.pushViewController(SettingViewController(), animated: true)
            default:
               break
            }
        }
    }
}

// 设置状态栏白色
extension MineViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
}
