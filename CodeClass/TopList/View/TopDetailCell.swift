//
//  TopDetailCell.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class TopDetailCell: UITableViewCell {
    
    @IBOutlet weak var topDetailImg: UIImageView!
    
    @IBOutlet weak var topDetailLabel: UILabel!
  
    @IBOutlet weak var topDetailName: UILabel!
   
    
    @IBOutlet weak var topDetailImgV: UIImageView!
    
    func setValueWithModel(Model:[TopDetailModel]){
    
        for model in Model{
        
            topDetailImg.sd_setImageWithURL(NSURL.init(string: model.pic_small!))
            
            topDetailLabel.text = model.title
            topDetailLabel.textColor = UIColor.whiteColor()
            topDetailName.text = model.author
            topDetailName.textColor = UIColor.whiteColor()
            
        
        
        
        }
    
    
    
    
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
