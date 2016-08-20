//
//  classSportCell.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class classSportCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var classCollectionView:UICollectionView?
    var layout:UICollectionViewFlowLayout?
    
    lazy var dataArr:[classHotModel] = {
        
        let array = [classHotModel]()
        
        return array
    }()
    
    
    func needModel(Model:[classHotModel]){
        
        
        dataArr = Model
        
        layoutCollectionView()
        addCollectionView()
        
    }
    
    
    
    func layoutCollectionView(){
        
        layout = UICollectionViewFlowLayout.init()
        
        layout?.itemSize = CGSizeMake(130, 130)
        
        
        
        
    }
    
    func addCollectionView(){
        
        
        classCollectionView = UICollectionView.init(frame: UIScreen.mainScreen().bounds, collectionViewLayout: layout!)
        
        classCollectionView?.backgroundColor = UIColor.clearColor()
        classCollectionView!.delegate = self
        classCollectionView!.dataSource = self
//        classCollectionView?.userInteractionEnabled = false
        classCollectionView?.scrollEnabled = false
        classCollectionView?.pagingEnabled = false
        contentView.addSubview(classCollectionView!)
        classCollectionView?.registerNib(UINib.init(nibName: "SportCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell123")
        
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return dataArr.count
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell123", forIndexPath: indexPath) as! SportCollectionViewCell
        
        let model = dataArr[indexPath.row]
        
        cell.setValueWithModel([model])
        
        
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
       
        
    }
   
    
    
    
    
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
      
      
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
