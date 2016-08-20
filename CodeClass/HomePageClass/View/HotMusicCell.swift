//
//  HotMusicCell.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class HotMusicCell: UITableViewCell {

    @IBOutlet weak var hotMusicPic: UIImageView!
    
    @IBOutlet weak var hotMusciName: UILabel!
    
    @IBOutlet weak var hotMusicIntroduction: UILabel!
    
    @IBOutlet weak var hotMusicImg: UIImageView!
    
    @IBOutlet weak var hotMusicPeople: UILabel!
    
    
    func setValueWithModel(Model:[hotMusic]){
        
        
        for model in Model{
        
            hotMusicPic.sd_setImageWithURL(NSURL.init(string: model.pic_300!))
            
            hotMusciName.text = model.title
            hotMusciName.textColor = UIColor.whiteColor()
            
            hotMusicIntroduction.text = model.desc
            hotMusicIntroduction.textColor = UIColor.whiteColor()
            
            hotMusicPic.layer.cornerRadius = 50
            hotMusicPic.layer.masksToBounds = true
            
//            imageView.layer.cornerRadius = width / 2
//            imageView.layer.masksToBounds = true
            
            
//            hotMusicImg.sd_setImageWithURL(NSURL.init(string: ""))
            
            hotMusicPeople.text = model.listenum
            hotMusicPeople.textColor = UIColor.whiteColor()
      
        
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
