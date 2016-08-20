//
//  HotDetailCell.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class HotDetailCell: UITableViewCell {

    
    @IBOutlet weak var detailNum: UILabel!
    
    @IBOutlet weak var detailTitle: UILabel!
  
    @IBOutlet weak var detailName: UILabel!
    
    func setValueWithModel(Model:[hotMusicDetail]){
    
        for model in Model{
        
            detailTitle.text = model.title
            detailTitle.textColor = UIColor.whiteColor()
            
            detailName.text = model.author
            detailName.textColor = UIColor.whiteColor()
        
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
