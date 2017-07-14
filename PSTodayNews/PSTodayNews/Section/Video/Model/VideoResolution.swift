//
//  VideoResolution.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/7/13.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class VideoResolution: NSObject {

    var height: Int = 0
    var width: Int = 0
    var name: String = ""
    var type: String = ""
    var url: String = ""
    
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
