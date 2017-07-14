//
//  VideoSubViewController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/23.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

let cellId = "VideoTableViewCell"

class VideoSubViewController: BaseViewController,VideoTableViewCellProtocol,ZFPlayerDelegate {

    var tableView: UITableView?
    fileprivate lazy var dataArr = [VideoModel]()
    
    // 初始化视频播放view
    fileprivate lazy var playerView: ZFPlayerView = {
        let playerView = ZFPlayerView()
        playerView.delegate = self
        // 当cell播放视频由全屏变为小屏时候，不回到中间位置
        playerView.cellPlayerOnCenter = true
        
        // 当cell划出屏幕的时候停止播放
        playerView.stopPlayWhileCellNotVisable = false
        //（可选设置）可以设置视频的填充模式，默认为（等比例填充，直到一个维度到达区域边界）
        playerView.playerLayerGravity = .resizeAspect
        // 静音
        playerView.mute = false
        return playerView
    }()
    fileprivate lazy var controlView: ZFPlayerControlView = ZFPlayerControlView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // 接收通知
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotification(notification:)), name: NSNotification.Name(rawValue: "ShareItemDidClickNotification"), object: nil)
        setupUI()
        loadData()
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

// 数据请求
extension VideoSubViewController {
    
    func loadData() {
        // 读取json数据
        let path = Bundle.main.path(forResource: "videoData", ofType: "json")
        let data: Data = NSData(contentsOfFile: path!)! as Data
        guard let rootDic = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            else { return }
        guard let videoList = rootDic?["videoList"]! as? [[String: Any]]
            else { return }
        // 数据存model
        for dict in videoList {
            let model = VideoModel(dict: dict)
            dataArr.append(model)
        }
        self.tableView?.reloadData()
    }
}

extension VideoSubViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupUI() {
        
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
//        tableView?.rowHeight = 220
        tableView?.estimatedRowHeight = 300  // 设置估算高度
        tableView?.rowHeight = UITableViewAutomaticDimension // 告诉tableView我们cell的高度是自动的
        view.addSubview(tableView!)
        // 注册cell
        tableView?.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! VideoTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.model = dataArr[indexPath.row]
        configureCell(withCell: cell, indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension VideoSubViewController {
    
    func configureCell(withCell cell: VideoTableViewCell, indexPath: IndexPath) {
//        cell.moreButtonClickClosure = {
//            print("更多")
//            // 弹出ShareView
////            let shareView = ShareView()
//            ShareView.show()
//        }
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

// cell点击,播放视频
extension VideoSubViewController {
    
    func VideoPlayClick(cell: VideoTableViewCell, model: VideoModel) {
        
        debugPrint("播放了");
        // 分辨率字典（key:分辨率名称，value：分辨率url)
        let dic = NSMutableDictionary()
        for resolution in model.playInfo {
            dic.setValue(resolution.url, forKey: resolution.name)
        }
        // 取出字典中的第一视频URL
        // 取出字典中的第一视频URL
        let videoURL = URL(string: dic.allValues.first! as! String)!
        
        let playerModel = ZFPlayerModel()
        playerModel.title            = model.title;
        playerModel.videoURL         = videoURL;
        playerModel.placeholderImageURLString = model.coverForFeed
        playerModel.tableView        = self.tableView;
        playerModel.indexPath        = tableView?.indexPath(for: cell)
        // 赋值分辨率字典
        playerModel.resolutionDic    = NSDictionary(dictionary: dic) as! [AnyHashable : Any]
        // player的父视图
        playerModel.fatherView       = cell.picImgView;
        
        // 设置播放控制层和model
        playerView.playerControlView(self.controlView, playerModel: playerModel)
        // 下载功能
        playerView.hasDownload = false
        // 自动播放
        playerView.autoPlayTheVideo()
    }
}

// MARK: - ZFPlayerDelegate

extension VideoSubViewController {
    
    func zf_playerDownload(_ url: String!) {
        // 此处是截取的下载地址，可以自己根据服务器的视频名称来赋值
        let name = (url as NSString).lastPathComponent
        print(name)
    }
}

