//
//  TopDetailModel.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class TopDetailModel: NSObject {
    var pic_small:String?
    var title:String?
    var author:String?
    var pic_s444:String?
    var song_id:String?
    
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
//        setValuesForKeysWithDictionary(dict2)
        
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        
        
    }
    
    
    
}
