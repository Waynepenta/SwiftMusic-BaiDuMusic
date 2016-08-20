//
//  HomepageHeaderView.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit

class HomepageHeaderView: UIScrollView {
    
    
    init(frame: CGRect,imageModel:[HomePageModel],tapAtion:Selector,timeInterval:NSTimeInterval,timerAction:Selector,target:AnyObject) {
        super.init(frame: frame)
        
        let width = frame.size.width
        
        let height = frame.size.height
        
        
        //遍历数据模型创建imageView及设置相关点击事件
        for (index,imageModel) in imageModel.enumerate(){
        
            
        
            
        let imageView = UIImageView.init(frame: CGRectMake(CGFloat(index)*width, 0, width, height))
            
            
            
            imageView.userInteractionEnabled = true
            //添加手势
            
            let tap = UITapGestureRecognizer.init(target: target, action: tapAtion)
            imageView.addGestureRecognizer(tap)
            
            imageView.sd_setImageWithURL(NSURL.init(string: imageModel.randpic_iphone6!))
            
            addSubview(imageView)
        
        }
        
        contentSize = CGSizeMake(CGFloat(imageModel.count)*width, height)
        
        pagingEnabled = true
        
        bounces = false
        
        
        NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: target, selector: timerAction, userInfo: self, repeats: true)
        
       
    }
    //加载xib时调用
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
