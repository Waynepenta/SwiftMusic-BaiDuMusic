//
//  ClassHotCell.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit
protocol turnaroundDelegate {
    
    func  turnView(ID:Int);
    
    
    
}

class ClassHotCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var delegete:turnaroundDelegate?
    
    var listID:String?
    
    var classCollectionView:UICollectionView?
    var layout:UICollectionViewFlowLayout?
    var classModel:classHotModel?
    
    lazy var dataArr:[classHotModel] = {
        
        let array = [classHotModel]()
    
        return array
    }()
    
    
    
    func layoutCollectionView(){
    
        layout = UICollectionViewFlowLayout.init()
        
        layout?.itemSize = CGSizeMake(130, 130)
        
        
        
    
    }

    func addCollectionView(){
        
        
        classCollectionView = UICollectionView.init(frame: UIScreen.mainScreen().bounds, collectionViewLayout: layout!)
        
        classCollectionView?.backgroundColor = UIColor.clearColor()
        classCollectionView!.delegate = self
        classCollectionView!.dataSource = self
        contentView.addSubview(classCollectionView!)
        classCollectionView?.registerNib(UINib.init(nibName: "classHotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell1")
        

     
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataArr.count
    
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell1", forIndexPath: indexPath) as! classHotCollectionViewCell
        
       
        let model = dataArr[indexPath.row]
        
           cell.addValueWithModel([model])

        
        
        
        
            return cell
        
    }
    
    
    func needModel(model:[classHotModel]){
        
       dataArr  = model
    
    
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
            let model = dataArr[indexPath.row]
        
            listID = model.ting_uid
    
        delegete?.turnView(Int(listID!)!)
      
    }
    
    
    
    
    
//    func analyData(){
//    
//        let str = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=6&offset=0&area=0&sex=0&abc=&from=ios&version=5.2.1&from=ios&channel=appstore"
//    
//        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: str, paratmeter: nil) { (respondeData, error) in
//            
//            
//            guard let respondObject = respondeData else {
//                
//                
//                print("网络或者数据错误")
//                
//                return
//                
//            }
//            
//            
//            for dict in respondObject["artist"] as! [[String:AnyObject]]{
//
//                let model = classHotModel(dict:dict)
//                
//                self.dataArr.append(model)
//           
//
//            }
//          
//            
//        }
//    
//   
//    
//    }
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        analyData()
        
        
        layoutCollectionView()
        
        addCollectionView()
        
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
 }
