//
//  TabBarViewController.swift
//  SwiftMusic
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit


class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        addChildViewController1()
       
        tabBar.barTintColor = UIColor.blackColor()

        tabBar.tintColor = UIColor.redColor()

        
       
        
        
        
        
    
  // 首页
        let homePageVC = HomePageViewController()
        
        let homePageNavc = UINavigationController(rootViewController: homePageVC)
        
        homePageVC.navigationItem.title = "首页"
        homePageVC.tabBarItem.title = "首页"
        homePageVC.tabBarItem.image = UIImage.init(named: "cm2_note_icn_listen@2x.png")
        
        addChildViewController(homePageNavc)
        
        
        //设置导航栏的颜色
        homePageNavc.navigationBar.barTintColor = UIColor.blackColor()
        //设置导航栏字体的颜色
        homePageNavc.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        
        
        
  //排行榜
        
        let topVC = TopListViewController()
        
        let topNavc = UINavigationController(rootViewController:topVC)
        
        topVC.navigationItem.title = "排行榜"
        topVC.tabBarItem.title = "排行榜"
        topVC.tabBarItem.image = UIImage.init(named:"cm2_note_icn_logo@2x.png")
        
        addChildViewController(topNavc)
        
        
        //设置导航栏的颜色
        topNavc.navigationBar.barTintColor = UIColor.blackColor()
        //设置导航栏字体的颜色
        topNavc.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
  //分类
        
        let categoryVC = ClassViewController()
        
        let categoryNav = UINavigationController(rootViewController:categoryVC)
        
        categoryVC.navigationItem.title = "分类"
        categoryVC.tabBarItem.title = "分类"
        categoryVC.tabBarItem.image = UIImage.init(named:"cm2_btm_icn_music_prs@3x.png" )
        
        addChildViewController(categoryNav)
        
        //设置导航栏的颜色
        categoryNav.navigationBar.barTintColor = UIColor.blackColor()
        //设置导航栏字体的颜色
        categoryNav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        
        
  //我的
        
        
        let userVC = UserViewController()
        
        let userNav  = UINavigationController(rootViewController:userVC)
        
        userVC.navigationItem.title = "我的"
        userVC.tabBarItem.title = "我的"
        userVC.tabBarItem.image = UIImage.init(named:"ic_radiopage_personal@3x.png" )
        
       
        
       
        //设置导航栏的颜色
        userNav.navigationBar.barTintColor = UIColor.blackColor()
        //设置导航栏字体的颜色
        userNav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
                
        let img = UIImageView.init(frame: CGRectMake(0, 0, 20, 20))
        img.image = UIImage.init(named: "sapi_profile_arrow@2x")
     
        
        userNav.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: img)
         addChildViewController(userNav)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    
    //封装的视图控制器 根据传入的值和对应的属性添加导航视图
//    func addChildViewControllerWith(controllerName:String,title:String,imageName:String){
//    
//        
//        let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
//        
//        
//        
//        //根据一个类名来加载一个类
////        let objClass:AnyObject = NSClassFromString(controllerName)!
//        
//        let objClass:AnyObject = NSClassFromString("\(nameSpace).\(controllerName)")!
//        
//        
//        //将objClass转化为真实的类
//        
//        let realClass = objClass as! UITableViewController.Type
//    
//        //根据realClass 实例化一个控制器对象
//        let controller = realClass.init(style: .Plain)
//        
//        //创建导航控制器并将controller作为根视图控制器
//        
//        let  navc = UINavigationController(rootViewController: controller)
//        
//        controller.tabBarItem.title = title
//        controller.navigationItem.title = title
//        
//        controller.tabBarItem.image = UIImage.init(named: imageName)
//        
//        //设置导航栏的颜色
//        navc.navigationBar.barTintColor = UIColor.blackColor()
//        //设置导航栏字体的颜色
//        navc.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
//        
//        
//        
//        addChildViewController(navc)
//        
//    
//    }
    
    
    
    //private  修饰方法属性 外界不可以访问，提高了代码的效率 但是UI控件的响应事件不可以用Private修饰，因为调用栈里面的UI响应事件不是由本类调用的
//  private  func addChildViewController1(){
//    
//    
//        let path = NSBundle.mainBundle().pathForResource("BaseTVC", ofType: "json")
//        
//        let data = NSData(contentsOfFile: path!)
//        
//        do{
//            
//            let rootArray = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
//            
//            for dict in rootArray as! [[String: String]] {
//                
//                addChildViewControllerWith(dict["controllName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
//                
//                
//            }
//            
//            
//            
//            
//            
//        }catch{
//            
//            
//            //默认的一些操作
//            
//            addChildViewControllerWith("HomePageViewController", title: "首页", imageName: "cm2_note_icn_listen@2x.png")
//            addChildViewControllerWith("TopListTableViewController", title: "排行榜", imageName: "cm2_note_icn_logo@2x.png")
//            addChildViewControllerWith("CategoryTableViewController", title: "分类", imageName: "cm2_note_icn_logo@2x.png")
//            addChildViewControllerWith("UserTableViewController", title: "我的", imageName: "ic_radiopage_personal@3x.png")
//            
//            
//            
//        }
//    
//    
//    
//    
//    
//    }
//    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
