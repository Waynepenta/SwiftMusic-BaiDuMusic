//
//  HomeDetailViewController.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class HomeDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableV:UITableView?
    var listID:String?
    var pic:String?
    
    
    lazy var modelArray:[hotMusicDetail] = {
    
        var modelArr = [hotMusicDetail]()
    
        return modelArr
    }()
    
    
    
    
    
    
    
    func analyData(){
        
        let str = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedanInfo&from=ios&listid=\(listID!)&version=5.2.3&from=ios&channel=appstore"
        
       
        
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: str, paratmeter: nil) { (respondeData, error) in
            
            guard let receiveObject = respondeData else{
                
                
                print("数据有问题")
                
                return
            }
            
            
            
            
            
            
            
             
          
            for dict in receiveObject["content"] as! [[String:AnyObject]]{

        
                let model = hotMusicDetail(dict:dict)
                
                self.modelArray.append(model)
               


    }
            
            
            
            
            
            
            
            
            
            
            
            
            dispatch_async(dispatch_get_main_queue(), { 
                
                self.tableV?.reloadData()
                
            })
            
            
         
            
        }
    
    
    
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.redColor()
        
        analyData()
        
        tableV = UITableView.init(frame: UIScreen.mainScreen().bounds)
        tableV?.delegate = self
        tableV?.dataSource = self
        
        view.addSubview(tableV!)
        
        tableV?.registerNib(UINib.init(nibName: "HotDetailCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        
        let blur = UIBlurEffect(style: .Dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = UIScreen.mainScreen().bounds
        tableV!.backgroundView = blurView
        
        
        
        
        let headView = UIImageView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width , 200))
        headView.sd_setImageWithURL(NSURL.init(string: pic!))
        
        
        tableV?.tableHeaderView = headView
        
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HotDetailCell
        
        let model = modelArray[indexPath.row]
        
        cell.setValueWithModel([model])
        cell.backgroundColor = UIColor.clearColor()
        
        cell.detailNum.text = String(indexPath.row + 1)
        cell.detailNum.textColor = UIColor.whiteColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        return 100
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        MusicPlayer.shareMusicPlayer.index = indexPath.row
        
        
        MusicPlayer.shareMusicPlayer.songModel1 = modelArray
        
//        MusicPlayer.shareMusicPlayer.loadSongInfo()
        
        
        
        
        
        
        let view1 = PlayViewController()
        
        let model = MusicPlayer.shareMusicPlayer.playNeedModel
        
        
         let PlayID:hotMusicDetail = modelArray[indexPath.row]
        
        view1.playid = Int(PlayID.song_id!)
        
      
        navigationController?.pushViewController(view1, animated: true)
        
    
        
    }
    
    
    
    
    
    
    
    
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        let view1 = UIImageView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width , 200))
//        view1.sd_setImageWithURL(NSURL.init(string: pic!))
//        
//        
//        
//        return view1
//        
//    }
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
