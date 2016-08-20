//
//  AppDelegate.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
       window?.rootViewController = TabBarViewController()
//        window?.rootViewController = TESTViewController()
        
        
      let session = AVAudioSession()
        
        
        do {
        
            try  session.setCategory(AVAudioSessionCategoryPlayback)

        
        
        } catch{
        
            print("error------session.setCategory(AVAudioSessionCategoryPlayback)")
        
        
        }
        
        do{
        
        try session.setActive(true)
        
        }catch{
        
            print("error-------session.setActive(true)")
        
        }
        
        
        //开始接受用户响应事件
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
        resignFirstResponder()
        
    
        
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        return true
    }
    
    //接收到远程事件时这个方法启用
    override func remoteControlReceivedWithEvent(event: UIEvent?) {
        
        switch event!.subtype.rawValue {
        case UIEventSubtype.RemoteControlPlay.rawValue:
            
            MusicPlayer.shareMusicPlayer.startPlayMusic()
            
        case UIEventSubtype.RemoteControlPause.rawValue:
            
            MusicPlayer.shareMusicPlayer.stopPlayMusic()
            
        case UIEventSubtype.RemoteControlPreviousTrack.rawValue:
            
            MusicPlayer.shareMusicPlayer.previousMusic()
            
        case UIEventSubtype.RemoteControlNextTrack.rawValue:
            
            MusicPlayer.shareMusicPlayer.playNextSong()
            
        default:
        print("未知")
        }
        
        
        
    }
    
    
    
    
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    //应用程序活跃起来
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        
        //后台进入前台 调用这个方法
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        
        becomeFirstResponder()
        
        
        
        
        
        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

