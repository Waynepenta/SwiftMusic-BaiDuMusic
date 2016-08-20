//
//  UserSearchViewController.swift
//  SwiftMusic
//
//  Created by lanou on 16/8/4.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableV:UITableView?
    
    lazy var dataArray:[PlayModel] = {
        
        let array = [PlayModel]()
    
    
        return array
        
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        tableV = UITableView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width ,  UIScreen.mainScreen().bounds.size.height))
        tableV?.delegate = self
        
        tableV?.dataSource = self
        tableV?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        let blur = UIBlurEffect(style: .Dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = UIScreen.mainScreen().bounds
        tableV!.backgroundView = blurView
        tableV!.separatorStyle = .None
        
      
     
        
      dataArray = PlayMusicDataBase.shareDataBase.selectAllModels()
        
       
       
      
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UserSearchViewController.reload), name: "reload", object: nil)
        
        
        
        
         view.addSubview(tableV!)
        
        
        

        // Do any additional setup after loading the view.
    }
    
    func reload(){
    
        print("刷新成功了")
        
        dataArray = PlayMusicDataBase.shareDataBase.selectAllModels()
        
        [self.tableV?.reloadData()]
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
  
    
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        let model:PlayModel = dataArray[indexPath.row]
        
        cell?.textLabel?.text = model.song_id
        cell?.textLabel?.textColor = UIColor.whiteColor()
        cell?.backgroundColor = UIColor.clearColor()
            return cell!
    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.tableV?.reloadData()
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





