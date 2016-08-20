//
//  ClassViewController.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class ClassViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var tableV:UITableView?
    
    lazy var hotArray:[classHotModel] =  {
    
        let array = [classHotModel]()
    
        return array
    }()
    
    lazy var hotArraySport:[classHotModel] =  {
        
        let array = [classHotModel]()
        
        return array
    }()
    
    lazy var heartArray:[classHotModel] = {
    
        let array = [classHotModel]()
        
        return array
    
    }()
    
    
    
    func analyData(){
    
        
        let  str = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=6&offset=0&area=0&sex=0&abc=&from=ios&version=5.2.1&from=ios&channel=appstore"
      
    NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: str, paratmeter: nil) { (respondeData, error) in
        
        guard let respondObject = respondeData else{
            
            
            print("网络或者数据错误")
            
            return
            
        }
        
        for dict in respondObject["artist"] as! [[String:AnyObject]]{
            
            let model = classHotModel(dict:dict)
            
            self.hotArray.append(model)
            
         
   
    }
       
        dispatch_async(dispatch_get_main_queue(), { 
            
            self.tableV?.reloadData()
            
            
        })
        
        
        }
    
    
    
    
    
    }
    
    func analyDataWithSport(){
        
        
        let  str = "http://tingapi.ting.baidu.com/v1/restserver/ting/?method=baidu.ting.scene.getCategoryScene&category_id=0&version=5.2.5&from=ios&channel=appstore"
        
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: str, paratmeter: nil) { (respondeData, error) in
            
            guard let respondObject = respondeData else{
                
                
                print("网络或者数据错误")
                
                return
                
            }
            
            for dict in respondObject["result"] as! [[String:AnyObject]]{
                
                let model = classHotModel(dict:dict)
                
                self.hotArraySport.append(model)
                
               
                
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                
                self.tableV?.reloadData()
                
                
            })
            
            
        }
        
        
        
        
        
    }
    
    
    
    func analyDataHeart(){
        
        
        let  str = "http://tingapi.ting.baidu.com/v1/restserver/ting/?method=baidu.ting.scene.getCategoryScene&category_id=3&version=5.2.5&from=ios&channel=appstore"
     
        
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: str, paratmeter: nil) { (respondeData, error) in
            
            guard let respondObject = respondeData else{
                
                
                print("网络或者数据错误")
                
                return
                
            }
            
            for dict in respondObject["result"] as! [[String:AnyObject]]{
                
                let model = classHotModel(dict:dict)
                
                self.heartArray.append(model)
                
                
                
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                
                self.tableV?.reloadData()
                
                
            })
            
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        analyData()
        
        analyDataWithSport()
        
        analyDataHeart()
        
        
        
        tableV = UITableView.init(frame: UIScreen.mainScreen().bounds)
        
        tableV?.delegate = self
        tableV?.dataSource = self
        
        view.addSubview(tableV!)
        
        let blur = UIBlurEffect(style: .Dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = UIScreen.mainScreen().bounds
        tableV!.backgroundView = blurView
        tableV!.separatorStyle = .None
        
        tableV?.registerNib(UINib.init(nibName: "ClassHotCell", bundle: nil), forCellReuseIdentifier: "cell3")
        tableV?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        
        
        
        tableV?.registerNib(UINib.init(nibName: "TESTTableViewCell", bundle: nil), forCellReuseIdentifier: "cell5")
        
       tableV?.registerNib(UINib.init(nibName: "classSportCell", bundle: nil), forCellReuseIdentifier: "cell4")
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
            
        }else if section == 1{
        
        
            return 1
        }else if section == 2{
        
        
            return 1
        }else{
        
        
            return 10
        
        }
        
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell3", forIndexPath: indexPath) as! ClassHotCell
            
            cell.backgroundColor = UIColor.clearColor()
//            let model = hotArray[indexPath.row]
            cell.needModel(hotArray)
            
            cell.delegete = self
            
            return cell
        }else if indexPath.section == 1{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("cell4", forIndexPath: indexPath) as! classSportCell
            
            cell.needModel(hotArraySport)
         
            cell.backgroundColor = UIColor.clearColor()
//
            return cell
        
        
        
        }else if indexPath.section == 2{
        
            let cell = tableView.dequeueReusableCellWithIdentifier("cell4", forIndexPath: indexPath) as! classSportCell
            
            cell.needModel(heartArray)
            
            cell.backgroundColor = UIColor.clearColor()
            //
            return cell
            
        
        
        
        }else {
        
        
            let cell = tableView.dequeueReusableCellWithIdentifier("cell5", forIndexPath: indexPath) as! TESTTableViewCell
            
            //            cell.needModel(hotArraySport)
            //
            return cell
        
        
            
            
            
        }
        
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 270
        }else if indexPath.section == 1{
        
            return 1000
        
        }else if indexPath.section == 2{
        
        
            return 580
            
        }else{
        
            return 760
        
        }
       
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        
            return hotArray.count
            
   
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view1 = UIView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width , 30))
        
        let label = UILabel.init(frame: CGRectMake(10, 15, 100, 20))
      
        if section == 0 {
            label.text = "热门歌手"
        }else if section == 1{
        
            label.text = "活动"
        
        }else if section == 2{
        
            label.text = "心情"
        
        }else{
        
            label.text = "1111"
        
        }
        
        
        
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.italicSystemFontOfSize(18)
        
        let btn = UIButton.init(type: .Custom)
        btn.frame = CGRectMake(290, 15, 100, 20)
        btn.setTitle("MoreSinger", forState: .Normal)
        
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.addTarget(self, action: #selector(ClassViewController.btnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        btn.titleLabel?.font = UIFont.italicSystemFontOfSize(14)
        btn.titleLabel?.textAlignment = .Center
        
        let label1 = UILabel.init(frame: CGRectMake(0, 40, UIScreen.mainScreen().bounds.size.width , 1))
        label1.backgroundColor = UIColor.whiteColor()
        
        view1.addSubview(label)
        view1.addSubview(btn)
        view1.addSubview(label1)
        
        return view1
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            
           return 50
        }else{
        
        
            return 50
        }
        
        
    }
    
    
    
    func btnAction(btn:UIButton){
    
    
        
    
    
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        
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

extension ClassViewController: turnaroundDelegate{


    func turnView(ID: Int) {
        let view1 = hotSingerViewController()
        
        view1.listID = ID
        
        navigationController?.pushViewController(view1, animated: true)
    }





}


