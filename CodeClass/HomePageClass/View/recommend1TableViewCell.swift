//
//  recommend1TableViewCell.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/26.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class recommend1TableViewCell: UITableViewCell {
    
    @IBOutlet weak var recommendScrollView: UIScrollView!
    
    func  setImageArray(recommendModels:[recommendModel],target:AnyObject,action:Selector){
        
        
        let width = (UIScreen.mainScreen().bounds.size.width-60)/2
        
        let height = width
        
        for (index,model) in recommendModels.enumerate(){
            
            let imageView = UIImageView.init(frame: CGRectMake(15+(CGFloat( index)*UIScreen.mainScreen().bounds.size.width/2), 0, width, height))
            let titleLabel = UILabel.init(frame: CGRectMake(CGFloat(index)*UIScreen.mainScreen().bounds.size.width/2, 195, UIScreen.mainScreen().bounds.size.width/2, 30))
            titleLabel.text = model.title
            titleLabel.font = UIFont.italicSystemFontOfSize(16)
            titleLabel.textAlignment = .Center
            titleLabel.textColor = UIColor.whiteColor()
            
            let tap = UITapGestureRecognizer.init(target: target, action: action)
            
            imageView.addGestureRecognizer(tap)
            imageView.sd_setImageWithURL(NSURL.init(string: model.pic!))
            imageView.layer.cornerRadius = width / 2
            imageView.layer.masksToBounds = true
            
            
            
            
            recommendScrollView.addSubview(titleLabel)
            recommendScrollView.addSubview(imageView)
            recommendScrollView.contentSize = CGSizeMake(2*UIScreen.mainScreen().bounds.size.width, 0)
            recommendScrollView.pagingEnabled = true
            recommendScrollView.bounces = false
            recommendScrollView.showsVerticalScrollIndicator = false
            recommendScrollView.showsHorizontalScrollIndicator = false
            imageView.userInteractionEnabled = true
            
            
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
