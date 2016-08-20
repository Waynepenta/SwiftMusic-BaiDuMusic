//
//  classHotCollectionViewCell.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class classHotCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var collectionCellImg: UIImageView!
    
    func addValueWithModel(Model:[classHotModel]){
    
        for model in Model{
        collectionCellImg.sd_setImageWithURL(NSURL.init(string: model.avatar_middle!))
         collectionCellImg.layer.cornerRadius = collectionCellImg.frame.size.width / 2
          collectionCellImg.layer.masksToBounds = true
        
        collectionName.text = model.name
            collectionName.textColor = UIColor.whiteColor()
        
        }
        
    
    
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        // Initialization code
    }

}
