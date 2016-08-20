//
//  hotMusicDetail.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class hotMusicDetail: NSObject {
        var title:String?
        var author:String?
    var song_id:String?
    var album_id:String?
    var album_title:String?
    var ting_uid:String?
    var all_artist_id:String?
    var all_rate:String?
    
    
    
    var pic_small:String?
//    var title:String?
//    var author:String?
    var pic_s444:String?
//    var song_id:String?
    
    
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        
        
    }
    
    
    

}
