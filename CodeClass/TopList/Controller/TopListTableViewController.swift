//
//  TopListTableViewController.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class TopListTableViewController: UITableViewController {
    
    lazy var ModelArray:[TopModel] = {
        
        var  ModeArr = [TopModel]()
    
        return ModeArr
    }()
    
    
    
    
    func analyData(){
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: Macro.topListUrl, paratmeter: nil) { (respondeData, error) in
            
            
            guard let respondObject = respondeData else{
                
                
                print("网络或者数据错误")
                
                return
                
            }
            
            
            for dict in respondObject["content"] as! [[String:AnyObject]]{
            
            
                let model = TopModel(dict:dict)
                
                
                self.ModelArray.append(model)
             
           
            
            }
            
           dispatch_async(dispatch_get_main_queue(), { 
            
                self.tableView.reloadData()
            
           })
            
            
            
            
        }
        
        
    
    
    
    
    
    
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        analyData()
        
        tableView.registerNib(UINib.init(nibName: "TopListCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        
        
        let blur = UIBlurEffect(style: .Dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = UIScreen.mainScreen().bounds
        tableView.backgroundView = blurView
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ModelArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        

        return cell
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
        
    }
    
    
    
    
    

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
