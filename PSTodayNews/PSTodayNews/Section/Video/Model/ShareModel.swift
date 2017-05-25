//
//  ShareModel.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/23.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class ShareModel: NSObject {

    var icon: String?
    var icon_night: String?
    var title: String?

    init(dict: [String: AnyObject]) {
        super.init()
        icon = dict["icon"] as? String
        icon_night = dict["icon_night"] as? String
        title = dict["title"] as? String
    }
}
