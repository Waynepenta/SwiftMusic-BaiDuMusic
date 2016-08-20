
//  MusicPlayer.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

protocol MusicPlayerDelegate {
    
    func autoRefreshProgress(progess:Float);
    
}



class MusicPlayer: NSObject {
    
    //播放歌曲的第几首
    var index:Int?
    
    var songModel1:[hotMusicDetail]?
    
    var hotModel:[TopDetailModel]?
    
    
    //是否可以播放的标志
    
    var readToPlay:Bool?
    
    
    var playStyle:Int?
    
    
    var playNeedModel:PlayModel?
    
    
    
    //定义代理
    var delegate:MusicPlayerDelegate?
    
    var time:NSTimer?
    
    //音乐播放器单例类
    static var shareMusicPlayer:MusicPlayer =  {
        
       
        
        let instance = MusicPlayer()
        
        //AVPlayerItemDidPlayToEndTimeNotification 系统自带的通知
        NSNotificationCenter.defaultCenter().addObserver(instance, selector: #selector(MusicPlayer.playNextSong), name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
        //打开数据库
        PlayMusicDataBase.shareDataBase.openDatabase()
//        PlayMusicDataBase.shareDataBase.dataBase?.open()
        //创建表格
        PlayMusicDataBase.shareDataBase.creatDataBasetable("musictable")
        
        
        
        
        
        return instance
    
    }()
    
    lazy var avPlayer:AVPlayer = {
    
    
        let avplayer = AVPlayer()
    
    
        return avplayer
    }()
    
    
    //播放当前的Item
    var playerItem:AVPlayerItem?
    
    
    func loadSongInfo(){
        
         let songmodel = songModel1![index!]
        
        let songtest = Int(songmodel.song_id!)
        
        
        
        let songURl1 = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.getInfos&ts=1445484488&songid=\(songtest!)&nw=2&l2p=0&lpb=0&ext=mp3&format=json&from=ios&usup=1&lebo=0&aac=0&ucf=4&vid=&res=1&e=USbMxKUnchkbhCYmky%2B5RJ%2FpxskZMYC1wjYkv8AHsvo%3D&version=5.3.2&from=ios&channel=appstore"
       
        
//        let songUrl = Macro.songInfoOne + songmodel.song_id! +  Macro.songInfoTwo
    
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: songURl1, paratmeter: nil) { (respondeData, error) in
            
            
            guard let respondObject = respondeData else{
                
                
                print("网络或者数据错误")
                
                return
                
            }
            
            
            
            let  songinfo1 =  respondObject["songinfo"] as! [String:AnyObject]
            
            
           
                
                
            let songurl1 = respondObject["songurl"]!!["url"] as! [[String:AnyObject]]
            
            
            let songplay = songurl1[0]
            
            
            let playmodel1 = PlayModel.init(songinfo: songinfo1, songurl: songplay)
            
            self.playNeedModel = playmodel1
            
           
            //设置锁屏的信息
            
            self.setlockScreenInfo(self.playNeedModel!)
            
            
            
            
            
            
            
            
            
           
            
            self.needModel(playmodel1)
            
         
            NSNotificationCenter.defaultCenter().postNotificationName("loadData", object: nil)
            
            
           PlayMusicDataBase.shareDataBase.insertPlayModel(self.playNeedModel!)
            
            
            
          
            self.playMusic(playmodel1.file_link!)
//            self.playMusic("http://yinyueshiting.baidu.com/data2/music/239023737/239023737.mp3?xcode=da4a36cdddc4f06131189f16455400eb")
            print(playmodel1.file_link!)
          
          
        }
        
        
//        MusicPlayer.shareMusicPlayer.readToPlay = !MusicPlayer.shareMusicPlayer.readToPlay!
//    
    
    
    
    }
    
    
    func needModel(Model:PlayModel){
    
    
        playNeedModel = Model
    
    
    }
    
    
    
    
    func setlockScreenInfo(playmodel:PlayModel){
    
    //MPNowPlayingInfoCenter播放中心记录了当前正在播放的歌曲信息
        MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = nil
    
        var dict = [String:AnyObject]()
        
        //设置歌手名
        dict[MPMediaItemPropertyArtist] = playmodel.author
        //设置歌名
        dict[MPMediaItemPropertyTitle] = playmodel.title
        
        //设置专辑缩略图
        
        let imagedata = NSData.init(contentsOfURL: NSURL.init(string: playmodel.pic_radio!)!)
        
        let artwork = MPMediaItemArtwork.init(image: UIImage.init(data: imagedata!)!)
        
        dict[MPMediaItemPropertyArtwork] = artwork
        
        
        //设置给播放中心
        
        MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = dict
    
    
    }
    
    
    
    
    
    
    
    func playMusic(fileLink:String){
    //判断上一首的观察者 防止出现也指针
        
       
        
        if playerItem != nil {
            
         
             playerItem?.removeObserver(self, forKeyPath: "status")
            
          
            playerItem = AVPlayerItem.init(URL: NSURL.init(string: fileLink)!)
            
            avPlayer.replaceCurrentItemWithPlayerItem(playerItem)
            
             avPlayer.play()
            
             NSNotificationCenter.defaultCenter().postNotificationName("loadData", object: nil)
            
            
        }else{
    
       
        playerItem = AVPlayerItem.init(URL: NSURL.init(string: fileLink)!)
        //添加观察者
      
        avPlayer.replaceCurrentItemWithPlayerItem(playerItem)
            
            
        }
        
        
        playerItem?.addObserver(self, forKeyPath: "status", options: [.New,.Old], context: nil)
    
    }
    
    //检测歌曲加载的过程
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        switch change!["new"]!.integerValue {
        case AVPlayerItemStatus.Failed.rawValue:
            
            print("歌曲缓冲失败")
            
         
        case AVPlayerItemStatus.ReadyToPlay.rawValue:
            print("歌曲缓冲成功")
            
            readToPlay = true
            
            
            
            startPlayMusic()
            
         NSNotificationCenter.defaultCenter().postNotificationName("readToPlay", object: nil)
            
           
            
        case AVPlayerItemStatus.Unknown.rawValue:
            
            print("歌曲缓冲未知")
            
        default:
            print("默认")
        }
        
        
        
        
        
    }
    
    
    //播放歌曲
    func  startPlayMusic(){
    
        if readToPlay == true {
            
            time?.invalidate()
            
            time = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(MusicPlayer.timeAction), userInfo: nil, repeats: true)
    
            avPlayer.play()
         
            
        }
        
    }
    
    //定时器
    func timeAction(){
    
        let time = Int((playerItem?.currentTime().value)!)
        let timeScale = Int((playerItem?.currentTime().timescale)!)
        
        let progess = Float(time/timeScale)
    
        delegate?.autoRefreshProgress(progess)
    
        
        let dict = MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo
        
        if var tempdict = dict {
            
            let  duration = CMTimeGetSeconds((avPlayer.currentItem?.duration)!)
            //设置总时长
            tempdict[MPMediaItemPropertyPlaybackDuration] = duration
            
          //设置当前播放时间
            
            let currentTime = CMTimeGetSeconds((avPlayer.currentItem?.currentTime())!)
            
            tempdict[MPNowPlayingInfoPropertyElapsedPlaybackTime] = currentTime
         //设置播放速率
            
          tempdict[MPNowPlayingInfoPropertyDefaultPlaybackRate] = 1.0
            
            
            //设置中心
            
          MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = tempdict
            
            
            
            
            
        }
        
        
        
        
    
    }
    
    
    //上一首
    func previousMusic(){
    
        if index == 0 {
            
            index = (songModel1?.count)! - 1
        }else{
        
        
            index = index! - 1
        
        }
    
        loadSongInfo()
    
    }
    
    //下一首
    
    func nestMusic(){
    
        if index! == (songModel1?.count)! - 1{
            
            index = 0
        }else{
        
        
            index = index! + 1
        
        }
   
        loadSongInfo()
       
    }
    
    
    
    
    
    //停止
    func stopPlayMusic(){
    
        time?.invalidate()
        
        avPlayer.pause()
        
        readToPlay = false
        
  
    
    }
    
    
    
    func playNextSong(){
    
        switch playStyle! {
        case 0:
            
            playRound()
            print("循环播放")
        case 1:
        
            playSong()
            print("单曲播放")
        case 2:
            playRandom()
            print("随机播放")
        case 3:
            playOrder()
            print("顺序播放")
            
            
            
        default:
            
            print("默认")
            
        }
        
    
    
    
    
    }
    
    
    private func playSong(){
    
        playMusic(playNeedModel!.file_link!)
    
    
    }
    
    
    private func playRound(){
        
    
        index = index! == (songModel1?.count)! - 1 ? 0: index! + 1
        
        loadSongInfo()
    }
    
    
    private func playOrder(){
    
        if index == (songModel1?.count)! - 1{
            avPlayer.pause()
            
            time?.invalidate()
        }else{
        
            index! += 1
            
            loadSongInfo()
            
        }
    
    
    }
    
    //随机播放
    private func playRandom(){
    
  let tempIndex = arc4random_uniform(UInt32(songModel1!.count))
    
    index = Int(tempIndex)
    
    loadSongInfo()
    
    
    }
    
    //快进(进度条的点击事件)
    
    func seekToTime(progess:Float){
        
        
        
        avPlayer.seekToTime(CMTimeMakeWithSeconds(Float64(progess), (playerItem?.currentTime().timescale)!))
   
    }
    
    
    
    func downLoad(){
    
        
        if let tempMoel = playNeedModel {
            MusicPlayerDownLoad.shareMusicDownLoad.CreatDownLoadTask(tempMoel)
        }
    
    
    
    }
    
    
    
    
    
    
    
    
    
    

}
