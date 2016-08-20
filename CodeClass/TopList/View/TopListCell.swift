//
//  TopListCell.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class TopListCell: UITableViewCell {
    
    @IBOutlet weak var topImage: UIImageView!
    
    @IBOutlet weak var topTitle: UILabel!
    
    @IBOutlet weak var contextNumOne: UILabel!
    
    @IBOutlet weak var contextNumTwo: UILabel!
    
    @IBOutlet weak var contextThree: UILabel!
    
    @IBOutlet weak var contextFour: UILabel!
    
    func setValueWithModel(Model:[TopModel]){
    
        for (index1,model) in Model.enumerate(){
        
            topImage.sd_setImageWithURL(NSURL.init(string: model.pic_s192!))
            
            topTitle.text = model.name
            topTitle.textColor = UIColor.whiteColor()
        
//            for model1 in model.content! {
//                
//                let str:String = " - "
//                
//      let  string  = (model1["title"] as! String) + str;
//                
//          contextNumOne.text = string + (model1["author"] as! String)
//        contextNumTwo.text = string + (model1["author"] as! String)
//         contextThree.text = string + (model1["author"] as! String)
//          contextFour.text = string + (model1["author"] as! String)
       
        let str:String = " - "
            
        let dict =  model.content![index1]
            
    let string1 = (dict["title"] as! String) + str
            
        contextNumOne.text = string1 + (dict["author"] as! String)
            
        
        let dict1 = model.content![index1 + 1]
            
            let string2 = (dict1["title"] as! String) + str
            
        contextNumTwo.text = string2 + (dict1["author"] as! String)
            
            
        let dict2 = model.content![index1 + 2]
            
            
       let string3  = (dict2["title"] as! String) + str
            
       contextThree.text = string3 + (dict2["author"] as! String)
            
        
            let dict3 = model.content![index1 + 3]
            
            let string4 = (dict3["title"] as! String) + str
           
        contextFour.text = string4 + (dict3["author"] as! String)
            
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
