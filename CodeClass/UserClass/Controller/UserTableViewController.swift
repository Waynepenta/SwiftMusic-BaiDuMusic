//
//  UserTableViewController.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class UserTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableV:UITableView?
    
    lazy var dataArray:[String] = {
    
        var  array = [String]()
    
        return array
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        tableV = UITableView.init(frame: CGRectMake(0,0, UIScreen.mainScreen().bounds.size.width,UIScreen.mainScreen().bounds.size.height))
        
        
        tableV?.delegate = self
        tableV?.dataSource = self
        tableV?.backgroundColor = UIColor.blueColor()
        view.addSubview(tableV!)
        tableV?.backgroundColor = UIColor.redColor()
        tableV?.registerNib(UINib.init(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        dataArray = ["歌曲列表","下载列表","最近播放","设置"]
        
        
        

        
       
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let   cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UserTableViewCell
        
      
        cell.userLabel.text = dataArray[indexPath.row]
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}






