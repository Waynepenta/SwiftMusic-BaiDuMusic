//
//  hotSingerViewController.swift
//  SwiftMusic
//
//  Created by lanou on 16/8/3.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class hotSingerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var  tableV:UITableView?
    var  listID:Int = 0
//    var  songModel:[hotMusicDetail]?
    
    lazy var dataArray:[TopDetailModel] = {
        let array = [TopDetailModel]()
        
        return array
    }()
    
    lazy var songModel:[hotMusicDetail] = {
        
        let array = [hotMusicDetail]()
        
        return array
        
    }()
    
    
    
    
    func analyData(){
    
        let url = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getSongList&format=json&tinguid=\(listID)&artistid(null)&limits=30&order=2&offset=0&version=5.2.5&from=ios&channel=appstore"
        
   
        
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: url, paratmeter: nil) { (respondeData, error) in
         
            
            guard let respondObject = respondeData else{
                
                
                return
                
            }
            
            for dict in respondObject["songlist"] as! [[String:AnyObject]]{
            
                
                let model = TopDetailModel.init(dict: dict)
                
                self.dataArray.append(model)
                
                let model1 = hotMusicDetail.init(dict: dict)
                
                self.songModel.append(model1)
                
       
           
            }
            
            
            dispatch_async(dispatch_get_main_queue(), { 
                
                self.tableV?.reloadData()
            })
          
            
        }
   
   
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analyData()
        
        tableV = UITableView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
        tableV?.delegate = self
        tableV?.dataSource = self
        view.addSubview(tableV!)
      
        
        let blur = UIBlurEffect(style: .Dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = UIScreen.mainScreen().bounds
        tableV!.backgroundView = blurView
        tableV?.separatorStyle = .None
        
        tableV?.registerNib(UINib.init(nibName: "HotDetailCell", bundle: nil), forCellReuseIdentifier: "cell")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HotDetailCell
        
        let mode = dataArray[indexPath.row]
        
        cell.detailTitle.text = mode.title
        cell.detailName.text = mode.author
        cell.backgroundColor = UIColor.clearColor()
        cell.detailNum.text = String(indexPath.row + 1)
        cell.detailNum.textColor = UIColor.redColor()
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 100
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        MusicPlayer.shareMusicPlayer.index = indexPath.row
        MusicPlayer.shareMusicPlayer.songModel1 = songModel
        
        
    let view1 =  PlayViewController()
        
        let model = dataArray[indexPath.row]
        view1.playid = Int(model.song_id!)
       
        
       navigationController?.pushViewController(view1, animated: true)
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
