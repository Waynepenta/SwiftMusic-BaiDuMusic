//
//  TopDetailViewController.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class TopDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableV:UITableView?
    var TypeID:Int = 0
    var header:UIImageView?
    var topPic:String?
    
    lazy var topDetailArray:[TopDetailModel] = {
    
            let array = [TopDetailModel]()
        
            return array
    }()
    
    lazy var hotArray:[hotMusicDetail] = {
    
        let array = [hotMusicDetail]()
    
        return array
    }()
    
    
    
    
    func analyData(){
        
        
        let string = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.billboard.billList&type=\(TypeID)&format=json&offset=0&size=50&from=ios&fields=title,song_id,author,resource_type,havehigh,is_new,has_mv_mobile,album_title,ting_uid,album_id,charge,all_rate&version=5.2.1&from=ios&channel=appstore"
    
        print("我要看这里\(string)")
        
    NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: string, paratmeter: nil) { (respondeData, error) in
        
        guard let respondObject = respondeData else{
            
            
            print("网络或者数据错误")
            
            return
            
        }
        
        
     
        
        for dict in respondObject["song_list"] as! [[String:AnyObject]]{
            
            
            let model = TopDetailModel(dict: dict)
            
            
            self.topDetailArray.append(model)
     
            let model1  = hotMusicDetail(dict:dict)
            
            self.hotArray.append(model1)
            
        }
        
            dispatch_async(dispatch_get_main_queue(), { 
                
                self.tableV?.reloadData()
                
                
            })
        
        
        }
    
    
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        analyData()
        
        
//        let head = UIImageView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width , 200))
//      
//        tableV?.tableHeaderView = head
        
        
        
        tableV = UITableView.init(frame: UIScreen.mainScreen().bounds)
        tableV?.delegate = self
        tableV?.dataSource = self
        
        tableV?.registerNib(UINib.init(nibName: "TopDetailCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        let blur = UIBlurEffect(style: .Dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = UIScreen.mainScreen().bounds
        tableV!.backgroundView = blurView
        tableV!.separatorStyle = .None
      
    
        
        view.addSubview(tableV!)
        
//        let head = UIImageView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width , 200))
        
        tableV?.tableHeaderView = self.addView(topPic!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addView(str:String) -> UIView{
    
        let head = UIImageView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width , 200))
        head.sd_setImageWithURL(NSURL.init(string: str))
        
        return head
    }
    
    
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return topDetailArray.count
        
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TopDetailCell
        
        let model = topDetailArray[indexPath.row]
        cell.setValueWithModel([model])
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 150
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
      
        
        MusicPlayer.shareMusicPlayer.index = indexPath.row
        
        MusicPlayer.shareMusicPlayer.songModel1 = hotArray
        
        
        
          let view1 = PlayViewController()
        
        
        let playmodel:TopDetailModel = topDetailArray[indexPath.row]
        
        view1.playid = Int(playmodel.song_id!)
        
        
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
