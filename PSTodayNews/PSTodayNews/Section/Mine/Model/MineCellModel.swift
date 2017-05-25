//
//  MineCellModel.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/22.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class MineCellModel: NSObject {

    var title: String?
    var subtitle: String?
    var isHiddenLine: Bool?
    var isHiddenSubtitle: Bool?
    
    init(dict: [String: AnyObject]) {
        super.init()
        title = dict["title"] as? String
        subtitle = dict["subtitle"] as? String
        isHiddenLine = dict["isHiddenLine"] as? Bool
        isHiddenSubtitle = dict["isHiddenSubtitle"] as? Bool
    }
}
