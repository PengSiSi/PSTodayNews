//
//  VidelModel.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/7/13.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class VideoModel: NSObject {
    /** 标题 */
    var title: String?
    /** 描述 */
    var videoDescription: String?
    /** 视频地址 */
    var playUrl: String?
    /** 封面图 */
    var coverForFeed: String?
    /** 视频分辨率的数组 */
    var playInfo: [VideoResolution] = [VideoResolution]()
    var date: NSNumber?
    
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "description" {
            self.videoDescription = value as! String?
        }
    }
    override func setValue(_ value: Any?, forKey key: String) {
        // 1.判断当前取出的key是否是用户
        if key == "playInfo" {
            var models = [VideoResolution]()
            for dict in value as! [[String: AnyObject]] {
                models.append(VideoResolution(dict: dict))
            }
            playInfo = models
            return
        }
        
        if key == "date" {
            date = value as! NSNumber?
        }
        
        super.setValue(value, forKey: key)
    }
}
