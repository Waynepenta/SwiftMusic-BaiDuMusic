//
//  recommendModel.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class recommendModel: NSObject {
    
    var collectnum:String?
    var listenum:String?
    var listid:String?
    var pic:String?
    var tag:String?
    var title:String?
    var type:String?
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    

}
