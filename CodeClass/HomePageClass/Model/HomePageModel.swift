//
//  HomePageModel.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class HomePageModel: NSObject {
    
    var randpic:String?
    var randpic_ios5:String?
    var randpic_desc:String?
    var randpic_ipad:String?
    var randpic_qq:String?
    var randpic_2:String?
    var randpic_iphone6:String?
    var randpic_type:String?
    var ipad_desc:String?
    var special_type = 0
    var is_publish:String?
    var mo_type:String?
    var type = 0
    var code:String?
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
        
    }
    
    

}
