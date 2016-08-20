//
//  classHotModel.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class classHotModel: NSObject {
    
    var name:String?
    
    var avatar_middle:String?
    
    var scene_name:String?
    
    var icon_ios:String?
    
    var ting_uid:String?
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        
        
    }
    

}
