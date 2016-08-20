//
//  Macro.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class Macro: NSObject {

    static  let homePageHeaderUrl:String = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.plaza.getFocusPic&format=json&from=ios&version=5.2.3&from=ios&channel=appstore"
    
    static let hotRecommend:String = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.getHotGeDanAndOfficial&num=4&version=5.2.3&from=ios&channel=appstore"
    
    static let  hotMusicUrl:String = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedan&page_no=1&page_size=30&from=ios&version=5.2.3&from=ios&channel=appstore"
    
    static let hotDetailUrl:String = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedanInfo&from=ios&listid=%d&version=5.2.3&from=ios&channel=appstore"
    static let topListUrl:String = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.billboard.billCategory&format=json&from=ios&version=5.2.1&from=ios&channel=appstore"
    
  static  let songInfoOne:String = " http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.getInfos&ts=1445484488&songid="
    
  static  let songInfoTwo:String = "&nw=2&l2p=0&lpb=0&ext=mp3&format=json&from=ios&usup=1&lebo=0&aac=0&ucf=4&vid=&res=1&e=USbMxKUnchkbhCYmky%2B5RJ%2FpxskZMYC1wjYkv8AHsvo%3D&version=5.3.2&from=ios&channel=appstore"
    
    
    
    
    
    
}
