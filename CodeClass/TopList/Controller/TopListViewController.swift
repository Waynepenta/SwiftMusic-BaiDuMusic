//
//  TopListViewController.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class TopListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableV:UITableView?
    
    
    
    
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
                
                self.tableV!.reloadData()
                
            })
            
            
            
            
        }
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analyData()
        
        tableV = UITableView.init(frame: UIScreen.mainScreen().bounds)
        tableV?.delegate = self
        tableV?.dataSource = self
        
        tableV?.registerNib(UINib.init(nibName: "TopListCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        let blur = UIBlurEffect(style: .Dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = UIScreen.mainScreen().bounds
        tableV!.backgroundView = blurView
        tableV!.separatorStyle = .None
        view.addSubview(tableV!)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TopListCell
        
        let model = ModelArray[indexPath.row]
        
        cell.setValueWithModel([model])
        cell.backgroundColor = UIColor.clearColor()
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let view1 = TopDetailViewController()
        let model = ModelArray[indexPath.row]
        view1.TypeID = model.type
        view1.topPic = model.pic_s444
        
        
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
