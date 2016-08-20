//
//  NetWorkTool.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit
import AFNetworking

class NetWorkTool: AFHTTPSessionManager {

    static var shareNetWorkTool:NetWorkTool = {
    
        let instance = NetWorkTool()
    
    
        return instance
    }()
    
    
    
    
    
    
    
    
    
    enum requestMethod:String {
        case get = "GET"
        case post = "POST"
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //定义一个请求的回调
    typealias requestClosure = (respondObject:AnyObject?,error:NSError?) -> ()
    
    
    
    func httpRequest(method:requestMethod,urlString:String,paratmeter:[String:AnyObject]?,requestFinish:requestClosure){
        
        
        //定义一个请求成功的回调
        let successClosure = {
        
            (dataTasks:NSURLSessionDataTask,respondData:AnyObject?)
            in
            
            //成功则有respondObject数据，error没有数据
            requestFinish(respondObject: respondData,error: nil)
            
        
        
        }
        
        //定义一个请求失败的回调
        let failsureClosure = {
            
            (dataTasks:NSURLSessionDataTask?,error:NSError) -> ()
            in
            
            //失败respondObject没有数据 error肯定有数据
            requestFinish(respondObject: nil,error: error)
        
        
        }
        
        
        
        
        //根据请求找方法
        if method == .get{
        
    
            GET(urlString, parameters: paratmeter, progress: nil, success: successClosure, failure: failsureClosure)
        
        
        }else{
        
        
       POST(urlString, parameters: paratmeter, progress: nil, success: successClosure, failure: failsureClosure)
        
        }
    
    
    }
    
    
    
    
    
    
    
    
}
