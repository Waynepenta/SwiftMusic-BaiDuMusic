//
//  LyrcHelper.swift
//  SwiftMusic
//
//  Created by lanou on 16/8/2.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class LyrcHelper: NSObject {
    
    static var shareLyrcHelper:LyrcHelper = {
        
        let instance = LyrcHelper()
    
        return instance
    }()
    
    func setSongLyrcWithUrl(urlString:String) -> ([NSString],[NSString]){
        
        var lycArray:[NSString] = [NSString]()
        
        var timeArray:[NSString] = [NSString]()
        
        
        if urlString.characters.count == 0{
            
            print("没有歌词链接")
            
        }else{
        
            let lyrUlr = NSURL.init(string: urlString)
            let lyrcData = NSData.init(contentsOfURL: lyrUlr!)
            
            let lyrcString = NSString.init(data: lyrcData!, encoding: 4)
        
            let templyrcArray:[NSString] = lyrcString!.componentsSeparatedByString("\n")
            
            for perLyrc in templyrcArray{
            
            
                if perLyrc.length != 0 && perLyrc.hasPrefix("["){
                
                    let array = perLyrc.componentsSeparatedByString("]") as [NSString]
                    
                    let range:NSRange = array[0].rangeOfString(".")
                    
                    if range.length > 0 {
                        
                        lycArray.append(array[1])
                        let tempTimeArray = array[0].componentsSeparatedByString("[") as [NSString]
                        let time = tempTimeArray[1]
                        
                        let rangeTwo = time.rangeOfString(".")
                        let minutesString = time.componentsSeparatedByString(":")[0]
                        
                        let secondsString = time.componentsSeparatedByString(":")[1].componentsSeparatedByString(":")[0]
                        var msString:String?
                        if rangeTwo.length > 0 {
                            
                            msString = time.componentsSeparatedByString(":")[1].componentsSeparatedByString(".")[1]
                            
                            
                            
                            
                        }else{
                        
                        
                            msString = time.componentsSeparatedByString(":")[2]
                        
                        
                        
                        }
                        
                        let minutes = (minutesString as NSString).integerValue
                        let seconds = (secondsString as NSString).integerValue

                        let ms = (msString! as NSString).integerValue
                        let timer  = minutes * 60 + seconds + ms/100
                        
                        let timeString = String.init(format: "%.ld", timer)
                        
                        timeArray.append(timeString)

                    }
                    
                    
                
                
                
                
                
                
                
                }else if perLyrc.hasPrefix("[") == false && perLyrc.length != 0{
                    
                    lycArray.append(perLyrc)
                    let noSelec  = "<当前歌词不支持自动滚动>d"
                    lycArray.insert(noSelec, atIndex: 0)
                
                }
          
            
            }
            
           print("时间数组\(timeArray.count)")
            print("歌词数组\(lycArray.count)")
        
        
        
        
        }
        
        
    
    
    return (timeArray,lycArray)
    }
    
    

}
