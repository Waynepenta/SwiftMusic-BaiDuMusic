//
//  PlayViewController.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/29.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

import SDAutoLayout

import Masonry




class PlayViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var playMusciModle:PlayModel?
    
    var playid:Int?

    
    var playViewModel:PlayModel?
    
    var backImg:UIImageView?
    
    var playLoadData:PlayModel?
    
    var playStr:String?
    
    var timer:NSTimer?
    
    var tableV:UITableView?
    
    @IBOutlet weak var playScrollView: UIScrollView!
   
    var playImage:UIImageView?
    var playTitle:UILabel?
 
    var timeArray:[NSString] = [NSString]()
    var lrcArray:[NSString] = [NSString]()
  
    
    @IBOutlet weak var downLoad: UIButton!
    
    @IBOutlet weak var nextMusic: UIButton!
  
   
    
    @IBOutlet weak var playAndPause: UIButton!
  
    @IBOutlet weak var PreviousMusic: UIButton!
  
   
    @IBOutlet weak var playStyle: UIButton!
    
  
    @IBOutlet weak var endTime: UILabel!
    
    
    @IBOutlet weak var playSlider: UISlider!
    
    @IBOutlet weak var startTime: UILabel!
   
    
  
    
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        navigationController?.navigationBar.translucent = false
//        analyData()
        
        playScrollView.contentOffset = CGPointMake(CGFloat(1 * UIScreen.mainScreen().bounds.size.width), 0)
        
        playAndPause.setImage(UIImage.init(named: "player_pause"), forState: .Normal)
        
       addContro()
        
        //创建歌词tableview
        
        tableV = UITableView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 300))
        
        tableV?.delegate = self
        tableV?.dataSource = self
        
        playScrollView.addSubview(tableV!)
        
        
       
        
        
        
        
        
        
        
      
        
        
        //播放歌曲
        MusicPlayer.shareMusicPlayer.loadSongInfo()
        
        MusicPlayer.shareMusicPlayer.delegate = self
//
        MusicPlayer.shareMusicPlayer.playStyle = 0
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(PlayViewController.startPlayMusic), name: "readPlay", object: nil)
     

       
       Nstimer()
        

   
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlayViewController.reloadDataWithModel), name: "loadData", object: nil)
      
        
        

        // Do any additional setup after loading the view.
    }

    
    func timerAction(){
        
       
        UIView.beginAnimations("animation", context: nil)
        UIView.setAnimationDuration(0.1)
        UIView.setAnimationCurve(UIViewAnimationCurve.Linear )

        playImage!.transform = CGAffineTransformRotate(playImage!.transform, 0.05)
        
        UIView.commitAnimations()
        

        
  }

    func Nstimer(){
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(PlayViewController.timerAction), userInfo: nil, repeats: true)
    
    
    }
    
    func reloadDataWithModel(){
    
        
        let model  =  MusicPlayer.shareMusicPlayer.playNeedModel

        playImage?.sd_setImageWithURL(NSURL.init(string: (model?.pic_radio)!))
        
        playTitle?.text = model?.title
        
        endTime.text = setTime(Float((model?.file_duration)!))
    
        playSlider.maximumValue = Float((model?.file_duration)!)
        
        
        
        let playmodel  = MusicPlayer.shareMusicPlayer.playNeedModel
        
        
        let lrcResult = LyrcHelper.shareLyrcHelper.setSongLyrcWithUrl((playmodel?.lrclink)!)
        
        timeArray = lrcResult.0
        lrcArray = lrcResult.1
        
        tableV?.reloadData()
        
     
    
    }
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func startPlayMusic(){
        if MusicPlayer.shareMusicPlayer.readToPlay == true {
            
          playAndPause.setImage(UIImage.init(named: "player_pause") , forState: .Normal)
            
            
        }
        
        
        
    }
    
    
    func analyData(){
        
        let str = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.getInfos&ts=1445484488&songid=\(playid!)&nw=2&l2p=0&lpb=0&ext=mp3&format=json&from=ios&usup=1&lebo=0&aac=0&ucf=4&vid=&res=1&e=USbMxKUnchkbhCYmky%2B5RJ%2FpxskZMYC1wjYkv8AHsvo%3D&version=5.3.2&from=ios&channel=appstore"
        

        
        
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: str, paratmeter: nil) { (respondeData, error) in
            
            
            guard let receiveObject = respondeData else{
                
                
                print("数据有问题")
                
                return
            }
            
     
            
            let  model = receiveObject["songinfo"]! as! [String:AnyObject]
            
            let model1 = receiveObject["songurl"]!!["url"] as! [[String:AnyObject]]
            
            let model2 = model1[0]
            
            let playmodel = PlayModel.init(songinfo: model, songurl: model2)
            
      
            
            
            
//        self.playImage!.sd_setImageWithURL(NSURL.init(string: playmodel.pic_radio!))
//          self.playTitle!.text = playmodel.title
//           
//        self.endTime.text = self.setTime(Float(playmodel.file_duration))
//        
//        self.playSlider.maximumValue = Float(playmodel.file_duration)
            

            
        }
    
    
    
    
    }
    
    
    func setTime(progess:Float) -> String {
    
        let min = Int(progess) / 60
        
        let sec = Int(progess) % 60
        
        let timeStr = String.init(format: "%02d:%02d", min,sec)
        
    
        return timeStr
    
    
    }
    
    
    
    
    
    
    
    
    
    
    func addContro(){
        
        let blur = UIBlurEffect(style: .Dark)
     
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = UIScreen.mainScreen().bounds
        
        view.addSubview(blurView)
        
        
        playScrollView.contentSize = CGSizeMake(3*UIScreen.mainScreen().bounds.size.width, 0)
        
        
        playScrollView.pagingEnabled = true
        playScrollView.bounces = false
        
        
        
      
        playImage = UIImageView.init(frame: CGRectMake(110 + UIScreen.mainScreen().bounds.size.width , 60, 200, 200))
        playImage!.layer.cornerRadius =  200 / 2
        playImage!.layer.masksToBounds = true
        playScrollView.addSubview(playImage!)
        
        
        playTitle = UILabel.init(frame: CGRectMake(110 + UIScreen.mainScreen().bounds.size.width, 300, 200, 30))
        
        playTitle!.textColor = UIColor.redColor()
        
        playTitle!.textAlignment = .Center
        
        playScrollView.addSubview(playTitle!)
        
        
        startTime.text = "00 : 00"
        
        blurView.addSubview(startTime)
        
        endTime.text = "33333"
        endTime.textAlignment = .Center
        
        blurView.addSubview(endTime)
        
        
        PreviousMusic.titleLabel?.textAlignment = .Center
        PreviousMusic.tag = 101
        PreviousMusic.setBackgroundImage(UIImage.init(named: "playerprev"), forState: .Normal)
        PreviousMusic.setTitle("", forState: .Normal)
        PreviousMusic.addTarget(self, action: #selector(PlayViewController.previousMusic), forControlEvents: .TouchUpInside)
        
        
       blurView.addSubview(PreviousMusic)
        
        playAndPause.titleLabel?.textAlignment = .Center
        playAndPause.tag = 102
        blurView.addSubview(playAndPause)
        playAndPause.addTarget(self, action: #selector(PlayViewController.playAndPauseAction), forControlEvents: .TouchUpInside)
     
        
        
        nextMusic.titleLabel?.textAlignment = .Center
        nextMusic.tag = 103
        
        nextMusic.setBackgroundImage(UIImage.init(named: "player_next"), forState: .Normal)
        
        nextMusic.setTitle("", forState: .Normal)
        nextMusic.addTarget(self, action: #selector(PlayViewController.nextMusicAction), forControlEvents: .TouchUpInside)
        
        
        
        
        blurView.addSubview(nextMusic)
        
        
        
        
        
        
        downLoad.tag = 104
        downLoad.titleLabel?.textAlignment = .Center
        
        downLoad.setBackgroundImage(UIImage.init(named: "player_download2"), forState: .Normal)
        downLoad.setTitle("", forState: .Normal)
        
        downLoad.addTarget(self, action: #selector(downLoadAction), forControlEvents: .TouchUpInside)
        
        
        blurView.addSubview(downLoad)
        
        blurView.addSubview(playSlider)
        blurView.addSubview(playStyle)
        
        
        view.addSubview(playScrollView)
        
        playStyle.setBackgroundImage(UIImage.init(named: "bt_playpagen_control_order_normal@3x"), forState: .Normal)
        playStyle.addTarget(self, action: #selector(PlayViewController.playStyleAction), forControlEvents: .TouchUpInside)

        playStyle.setTitle("", forState: .Normal)
        
        
       
    
        
        
        
        
    
    
    }
    
    func playStyleAction(){
    
    
    
    
    
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //暂停和播放
    func playAndPauseAction(){
    
        if MusicPlayer.shareMusicPlayer.readToPlay == true {
            
            
            playAndPause.setImage(UIImage.init(named:"player_play"), forState: .Normal)
            MusicPlayer.shareMusicPlayer.stopPlayMusic()
            
            MusicPlayer.shareMusicPlayer.readToPlay = false
            
             timer!.invalidate()
            
            
        }else{
            
            MusicPlayer.shareMusicPlayer.readToPlay = true
            
            playAndPause.setImage(UIImage.init(named: "player_pause"), forState: .Normal)
            MusicPlayer.shareMusicPlayer.startPlayMusic()
            
              Nstimer()
   
            
        }
        
        
        
        
    
    
    
    
    
    }
    
    //下载
    func downLoadAction(){
    
        MusicPlayer.shareMusicPlayer.downLoad()
    
    
    }
    
    
    func sliderSeekToTime(slider:UISlider){
    
    
    MusicPlayer.shareMusicPlayer.seekToTime(slider.value)
    
    
    }
    
    
    //下一首歌
    func nextMusicAction(){
    
    
    MusicPlayer.shareMusicPlayer.nestMusic()
      
    
    }
    
    func previousMusic(){
    
    
    
      MusicPlayer.shareMusicPlayer.previousMusic()
    
    
    }
    
    
    
    //tableView的代理方法
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lrcArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if  cell == nil {
            
            cell = UITableViewCell.init(style: .Default, reuseIdentifier: "cell")
         
        }
        
        cell?.backgroundColor = UIColor.clearColor()
        cell?.textLabel?.textColor = UIColor.blackColor()

         cell?.textLabel?.textAlignment = .Center
        
        cell?.textLabel?.text = lrcArray[indexPath.row] as String
        
        return cell!
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}








extension PlayViewController: MusicPlayerDelegate{



    func autoRefreshProgress(progess: Float) {
        
        
        startTime.text = setTime(progess)
        
        playImage?.transform = CGAffineTransformRotate((playImage?.transform)! , 0.01)
        
       playSlider.value = progess
        
        for i in 0..<timeArray.count{
        
        let timeString = setTime((timeArray[i] as NSString).floatValue)
            if timeString == setTime(progess){
            let indexPath = NSIndexPath.init(forRow: i, inSection: 0)
            if tableV?.numberOfRowsInSection(0) > 0 {
                
                tableV?.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
                
                
                
            }
        
            }
        
        }
        
        
        
        
        
    }

    
  






}




