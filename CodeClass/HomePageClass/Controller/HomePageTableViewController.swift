//
//  HomePageTableViewController.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit
import SDWebImage

class HomePageTableViewController: UITableViewController {
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    let idef:String? = "123"
    
    
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
            
            
            
            self.tableView.reloadSections(NSIndexSet.init(index: 0), withRowAnimation: .Automatic)
            
            
           })
            
           
            
            
            
            
        }
    
    
    }
    
    
    
    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        anylaData()
        
        tableView.registerNib(UINib.init(nibName: "recommend1TableViewCell", bundle: nil), forCellReuseIdentifier: "cell1")
        
        self.tableView.registerNib(UINib(nibName:"nibName",bundle:nil),forCellReuseIdentifier:idef!)
        
        tableView.separatorStyle = .None
        
        tableView = UITableView.init(frame: self.view.frame, style: .Grouped)
        
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        

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
            
            let headerScrollerView = HomepageHeaderView.init(frame: CGRectMake(0, 0, screenWidth, 180), imageModel: self.imageModels, tapAtion:#selector(HomePageTableViewController.imageTapAction(_:)), timeInterval: 2, timerAction:#selector(HomePageTableViewController.turnToNext(_:)) , target: self)
            
            headerScrollerView.delegate = self
            
            self.tableView.tableHeaderView = headerScrollerView
            
            
            
            
//            let picArray = respondObject!["pic"] as! [[String:AnyObject]]
//            
//            
//            for (index,value) in picArray.enumerate(){
//                
//                let picModel = HomePageModel(dict:value)
//                
//                let imageView = UIImageView.init(frame: CGRectMake(CGFloat(index)*screenWidth, 0, screenWidth, 150
//                    ))
//                
//                imageView.sd_setImageWithURL(NSURL(string:picModel.randpic!))
//                
//                
//                self.scrollView.addSubview(imageView)
//
//                
//                
//            }
//            
//          self.scrollView.contentSize = CGSizeMake(CGFloat(picArray.count)*screenWidth, 150)
//            
//            self.scrollView.pagingEnabled = true
//            self.scrollView.showsVerticalScrollIndicator = false
//            self.scrollView.showsHorizontalScrollIndicator = false
        }
        
        
        
        
//         view.addSubview(scrollView)
        
        
        
        
        
        
//        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(HomePageTableViewController.turnToNext), userInfo: nil, repeats: true)
//        
        
        
        
        
        
        
        
        
        
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func turnToNext(timer:NSTimer){
    
        let tableHeaderView = timer.userInfo as! HomepageHeaderView
    
        let index = tableHeaderView.contentOffset.x/screenWidth
        
        tableHeaderView.setContentOffset(CGPointMake(CGFloat(index + 1)*screenWidth, 0), animated: true)
        
    
    }
    
    func imageTapAction(tap:UITapGestureRecognizer){
    
        
        
       print("gxdfgxfcgh")
        
        
        
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//        
//    }

  
    
    
    
   
    
    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 10
//    }
//
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//      
//      
////         let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! recommend1TableViewCell
//        
////        let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "cell")
////        let  cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! recommend1TableViewCell
////        
////        let  cell = tableView.dequeueReusableCellWithIdentifier(idef!, forIndexPath: indexPath) as! TESTCell
////        
////            cell.backgroundColor = UIColor.clearColor()
//
////            cell.setImageArray(hotRecommendModel, target: self, action: #selector(HomePageTableViewController.recommendAction(_:)))
//        
//        
////           cell.textLabel!.text = "111"
//        
//            return cell
//            
//    
//        // Configure the cell...
//       
//       
//    }

//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        
//        
//        
////        return (screenWidth - 60)/2
//        if indexPath.section == 0 {
//            return 230
//        }else{
//        
//        
//        return 180
//        }
//        
//        
//        
//    }
    
 
    
    
    
    

    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



//Swift中遵守协议的方式
extension HomePageTableViewController {

//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
//    
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
//        
//        // Configure the cell...
//        
//        return cell
//    }


    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
       let index =  scrollView.contentOffset.x/screenWidth
        
        if index == 5 {
            
            scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
         
        }
     
        
    }
    
    
    override func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        let index =  scrollView.contentOffset.x/screenWidth
        
        if index == 5 {
            
            scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
            
        }
    }
    

    func recommendAction(tap:UITapGestureRecognizer){
    
    
    
    
        print("点击了热门推荐")
    
    }





}










