//
//  hotMusic.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class hotMusic: NSObject {
    
    var title:String?
    var desc:String?
    var listenum:String?
    var pic_300:String?
    var listid:String?
    var pic_w300:String?
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        
        
    }
    

}
