//
//  AddCategoryModel.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/24.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import ObjectMapper

// http://is.snssdk.com/article/category/get_extra/v1/?version_code=6.1.2&app_name=news_article&vid=6AB8DE8F-DADF-4C93-A6EE-C81B88F94F44&device_id=14958264372&channel=App%20Store&resolution=1242*2208&aid=13&ab_version=127190,126061,128695,129540,127680,122834,130106,126065,123725,128454,129627,126072,129993,125503,125174,130167,127335,129538,126057,128478,129518,122948,130200,128166,130015,130094,114338,125071,127758&ab_feature=z1&ab_group=z1&openudid=f147bc351dc77e5f2da6b37337f44f513c0a3cf5&live_sdk_version=1.6.5&idfv=6AB8DE8F-DADF-4C93-A6EE-C81B88F94F44&ac=WIFI&os_version=10.3.1&ssmix=a&device_platform=iphone&iid=36424536574&ab_client=a1,f2,f7,e1&device_type=iPhone%206S%20Plus&idfa=36137365-CB03-4CE2-AFB2-8261BE190622&version=3715800923%7C12%7C1495522218

class AddCategoryModel: Mappable {

    var category: String?
    var web_url: String?
    var flags: Int?
    var name: String?
    var tip_new: Int?
    var default_add: Int?
    var concern_id: String?
    var type: Int?
    var icon_url: String?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        category <- map["category"]
        web_url <- map["web_url"]
        flags <- map["flags"]
        name <- map["name"]
        tip_new <- map["tip_new"]
        default_add <- map["default_add"]
        concern_id <- map["concern_id"]
        type <- map["type"]
        icon_url <- map["icon_url"]
    }
}
