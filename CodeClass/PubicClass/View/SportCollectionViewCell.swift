//
//  SportCollectionViewCell.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var sportlabel: UILabel!
    @IBOutlet weak var sportImg: UIImageView!
    
    func setValueWithModel(Model:[classHotModel]){
    
        for model in Model{
        
            sportImg.setImageWithURL(NSURL.init(string: model.icon_ios!)!)
            
            sportlabel.text = model.scene_name
            sportlabel.textColor = UIColor.whiteColor()
            sportlabel.textAlignment = .Center
         
        
        }
        
        
    
    
    }
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
