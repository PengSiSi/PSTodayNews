//
//  VideoTopTitle.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/23.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class VideoTopTitle: NSObject {

    /*
     {
     category = "video_new";
     flags = 0;
     "icon_url" = "";
     name = "\U63a8\U8350";
     "tip_new" = 0;
     type = 4;
     "web_url" = "";
     }
    */
    var category: String?
    
    var tip_new: Int?
    
    var web_url: String?
    
    var icon_url: String?
    
    var flags: Int?
    
    var type: Int?
    
    var name: String?

    init(dict: [String: AnyObject]) {
        super.init()
        category = dict["category"] as? String
        tip_new = dict["tip_new"] as? Int
        web_url = dict["web_url"] as? String
        icon_url = dict["icon_url"] as? String
        flags = dict["flags"] as? Int
        type = dict["type"] as? Int
        name = dict["name"] as? String
    }
}
