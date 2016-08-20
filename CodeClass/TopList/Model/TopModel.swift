//
//  TopModel.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class TopModel: NSObject {

    var name:String?
    var pic_s192:String?
    var content:[[String:AnyObject]]?
    var type:Int = 0
    var pic_s444:String?
    var song_id:String?
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        
    }
    
}
