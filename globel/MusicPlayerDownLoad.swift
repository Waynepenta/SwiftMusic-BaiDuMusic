//
//  MusicPlayerDownLoad.swift
//  SwiftMusic
//
//  Created by lanou on 16/8/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class MusicPlayerDownLoad: NSObject {
    
    
    var session:NSURLSession?
    
    var downloadTask1: NSURLSessionDownloadTask?
    
    static var shareMusicDownLoad:MusicPlayerDownLoad = {
    
        let instance = MusicPlayerDownLoad()
        
        // 如果NSOperationQueue是 非主队列则代理用协议里面的方法是在子线程里面调用，不能更新UI 如果是主队列，协议方法在主队列调用
        instance.session = NSURLSession.init(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: instance, delegateQueue: NSOperationQueue.mainQueue())
        
        return instance
    }()
    
    
    
    
    func CreatDownLoadTask(playModel: PlayModel){
    
       downloadTask1 = session?.downloadTaskWithURL(NSURL.init(string: playModel.file_link!)!)
       
        
        downloadTask1?.resume()
        
      
    }
    
    
    

}



extension MusicPlayerDownLoad:NSURLSessionDelegate{

    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL){
        
        let cachepath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true) [0]
        
        print(cachepath)
        
        let filepath = cachepath.stringByAppendingString("/\(downloadTask1!.response!.suggestedFilename!)")
        
        let fileManager = NSFileManager.defaultManager()
        
        do{
            
            try fileManager.moveItemAtPath(location.path!, toPath: filepath)
            
            
        } catch {
            
            
            print("false")
            
        }
    
       
    }

    
    
    //实时查看进度
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
        
        
        print(Float(totalBytesWritten)/Float(totalBytesExpectedToWrite))
        
        
    }


    


}



