//
//  VideoSubViewController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/23.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

let cellId = "VideoCellID"

class VideoSubViewController: BaseViewController {

    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // 接收通知
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotification(notification:)), name: NSNotification.Name(rawValue: "ShareItemDidClickNotification"), object: nil)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         NotificationCenter.default.removeObserver(self)
    }
    
    // 通知移除
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension VideoSubViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupUI() {
        
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = 220
        view.addSubview(tableView!)
        // 注册cell
        tableView?.register(UINib(nibName: "VideoCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! VideoCell
        cell.selectionStyle = .none
        configureCell(withCell: cell, indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension VideoSubViewController {
    
    func configureCell(withCell cell: VideoCell, indexPath: IndexPath) {
        cell.moreButtonClickClosure = {
            print("更多")
            // 弹出ShareView
//            let shareView = ShareView()
            ShareView.show()
        }
    }
    
    func receiveNotification(notification: Notification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        guard let _ = userInfo["shareItemTag"] , let _ = userInfo["shareItemTitle"] else {
            return
        }
        // 这样取值
        print("tag = \(userInfo["shareItemTag"] ?? 0 as AnyObject) title = \(userInfo["shareItemTitle"] ?? "" as AnyObject)")
    }
}

