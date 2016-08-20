//
//  UserViewController.swift
//  SwiftMusic
//
//  Created by lanou on 16/8/3.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class UserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
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
    
        view.addSubview(tableV!)
   
        tableV?.registerNib(UINib.init(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        dataArray = ["歌曲列表","下载列表","最近播放","设置"]
        
        let blur = UIBlurEffect(style: .Dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = UIScreen.mainScreen().bounds
        tableV!.backgroundView = blurView
        tableV!.separatorStyle = .None
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let   cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UserTableViewCell
        
        
        cell.userLabel.text = dataArray[indexPath.row]
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if  indexPath.row == 0 {
            
            let view1 = UserSearchViewController()
            
            navigationController?.pushViewController(view1, animated: true)
        }
     
        
        
    }
    
    
    
    
    

}
