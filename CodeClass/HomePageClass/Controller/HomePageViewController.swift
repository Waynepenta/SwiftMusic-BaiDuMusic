//
//  HomePageViewController.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/26.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate{

    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    var tableV:UITableView?
    
    
    lazy var scrollView:UIScrollView = {
        
        let tempScrollView = UIScrollView(frame: CGRectMake(0,0,UIScreen.mainScreen().bounds.size.width,150))
        
        return tempScrollView
    }()
    
    //存放轮播图的数据模型
    lazy var imageModels:[HomePageModel] = {
        
        var imageArray = [HomePageModel]()
        
        return imageArray
        
    }()
    //热门推荐的数组
    lazy var hotRecommendModel:[recommendModel] = {
        
        var recommendArray = [recommendModel]()
        
        return recommendArray
        
    }()
    
    //
    lazy var recomendLists:[String] = {
        
        let recommendList = [String]()
        
        return recommendList
    }()
    
    
    lazy var hotMusicArr:[hotMusic] = {
        
        let hotMusicArray = [hotMusic]()
    
        return hotMusicArray
    }()
    
    
    
    
    
    
    
    
    
    func anylaData(){
        
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: Macro.hotRecommend, paratmeter: nil) { (respondeData, error) in
            
            guard let respondObject = respondeData else{
                
                
                return
                
            }
            
            let array = respondObject["content"]!!["list"] as! [[String:AnyObject]]
            
            for dic in array{
                
                
                let hotModel = recommendModel.init(dict: dic)
                
                self.hotRecommendModel.append(hotModel)
                
                
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                
                
                
                self.tableV?.reloadData()
                
                
            })
            
            
            
            
            
            
        }
        
        
    }
    
    
    func CreatScrollview(){
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: Macro.homePageHeaderUrl, paratmeter: nil) { (respondeData, error) in
            
            
            guard let receiveObject = respondeData else{
                
                
                print("轮播图")
                
                return
            }
            
            
            for dict in receiveObject["pic"] as! [[String:AnyObject]]{
                
                
                let imageModel = HomePageModel(dict:dict)
                self.imageModels.append(imageModel)
                
                
                
            }
            
            self.imageModels.append(self.imageModels[0])
            
            let headerScrollerView = HomepageHeaderView.init(frame: CGRectMake(0, 0, self.screenWidth, 180), imageModel: self.imageModels, tapAtion:#selector(HomePageTableViewController.imageTapAction(_:)), timeInterval: 2, timerAction:#selector(HomePageTableViewController.turnToNext(_:)) , target: self)
            
            headerScrollerView.delegate = self
            
            self.tableV!.tableHeaderView = headerScrollerView
      
           
        
        
    }
    
    
    }
    
    func anylaHotMusic(){
    
         NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: Macro.hotMusicUrl, paratmeter: nil) { (respondeData, error) in
            
            
            guard let receiveObject = respondeData else{
                
                
                print("数据有问题")
                
                return
            }
            
            for dict in receiveObject["content"] as! [[String:AnyObject]] {
            
                
                let  model  = hotMusic(dict:dict)
                
                
                self.hotMusicArr.append(model)
          
                
            
            
            }
            
            
            dispatch_async(dispatch_get_main_queue(), { 
                
                self.tableV?.reloadData()
            })
          
            
        }
        
   }
    
    
    
    
    
    
    
    
    
    
   override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.redColor()
    
        
    
    
        anylaData()
        
        CreatScrollview()
    
        anylaHotMusic()
        
        tableV = UITableView.init(frame: CGRectMake(0, 0, screenWidth, screenHeight), style: .Plain)
    
        tableV?.delegate = self
        tableV?.dataSource = self
      tableV!.separatorStyle = .None
    
        view.addSubview(tableV!)
    
    let blur = UIBlurEffect(style: .Dark)
    let blurView = UIVisualEffectView(effect: blur)
    blurView.frame = UIScreen.mainScreen().bounds
    tableV!.backgroundView = blurView
    
    
        tableV?.registerNib(UINib.init(nibName: "recommend1TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        tableV?.registerNib(UINib.init(nibName: "HotMusicCell", bundle: nil), forCellReuseIdentifier: "cell1")

        // Do any additional setup after loading the view.
    }

   override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        
       return 2
        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }else{
        return hotMusicArr.count
        }
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 220
            
        }else{
        
        
            return 200
            
        }
      
        
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    
            return 40
    
    
    }
    
   
    
    
    
    
    
    
    
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            
//            let str:String = "热门推荐"
//            return str
//            
//        }else{
//        
//            let str:String = "热门歌单"
//            
//            return str
//        }
//      
//    }
    
//    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        
//        let headV = view as! UITableViewHeaderFooterView
//        
//        headV.textLabel?.font = UIFont.systemFontOfSize(15)
//        headV.textLabel?.textColor = UIColor.redColor()
//        
//        
//        
//    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view1 = UIView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width , 40))
            view1.backgroundColor = UIColor.clearColor()
            let label = UILabel.init(frame: CGRectMake(10, 10, 160, 20))
            label.text = "热门推荐"
            label.textColor = UIColor.whiteColor()
            view1.addSubview(label)
            let label1 = UILabel.init(frame: CGRectMake(0, 37, UIScreen.mainScreen().bounds.size.width , 1))
            label1.backgroundColor = UIColor.whiteColor()
            view1.addSubview(label1)
            
            return view1
            
        }else{
            let view1 = UIView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width , 40))
            view1.backgroundColor = UIColor.clearColor()
            let label = UILabel.init(frame: CGRectMake(10, 10, 160, 20))
            label.text = "热门歌单"
            label.textColor = UIColor.whiteColor()
            view1.addSubview(label)
            
            let label1 = UILabel.init(frame: CGRectMake(0, 37, UIScreen.mainScreen().bounds.size.width , 1))
            label1.backgroundColor = UIColor.whiteColor()
            view1.addSubview(label1)
            
            
            
            return view1
        
        
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TESTCell
//        
//        cell.textLabel?.text = "1111"
        if indexPath.section == 0{
        
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! recommend1TableViewCell
            
            cell.setImageArray(hotRecommendModel, target: self, action:#selector(HomePageViewController.imageTapAction(_:)))
            cell.backgroundColor = UIColor.clearColor()
            
            return cell
        
        
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! HotMusicCell
        
            cell.backgroundColor = UIColor.clearColor()
            
            let model = hotMusicArr[indexPath.row]
            cell.setValueWithModel([model])
            
            
        
        
            return cell
        
        
        }
    
        
    }
    
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let view1 = HomeDetailViewController()
        
        let model = hotMusicArr[indexPath.row]
        
        view1.listID = model.listid
        
        view1.pic = model.pic_w300
       
       navigationController?.pushViewController(view1, animated: true)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func turnToNext(timer:NSTimer){
        
        let tableHeaderView = timer.userInfo as! HomepageHeaderView
        
        let index = tableHeaderView.contentOffset.x/screenWidth
        
        tableHeaderView.setContentOffset(CGPointMake(CGFloat(index + 1)*screenWidth, 0), animated: true)
        
        
    }
    
    func imageTapAction(tap:UITapGestureRecognizer){
        
        
        
        print("gxdfgxfcgh")
        
        
        
        
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
     func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let index =  scrollView.contentOffset.x/screenWidth
        
        if index == 5 {
            
            scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
            
        }
        
        
    }
    
    
     func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        let index =  scrollView.contentOffset.x/screenWidth
        
        if index == 5 {
            
            scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
            
        }
    }
    
    
    func recommendAction(tap:UITapGestureRecognizer){
        
        
        
        
        print("点击了热门推荐")
        
    }
    
    
    

}










