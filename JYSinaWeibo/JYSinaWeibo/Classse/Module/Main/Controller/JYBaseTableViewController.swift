//
//  JYBaseTableViewController.swift
//  JYSinaWeibo
//
//  Created by apple on 15/10/28.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit

class JYBaseTableViewController: UITableViewController {

//    // 当实现这个方,并且给view设置值,不会再从其他地方加载view.xib storyboard
//    /*
//    在 loadView，如果:
//    1.设置view的值,使用设置的view
//    2.super.loadView() 创建TableView
//    
//    */
//    

    let userLogin = JYUserAccout.userLogin()
    
    override func loadView() {
        userLogin ? super.loadView() : setupVisitorView()
    }
//
//    /// 创建访客视图
    func setupVisitorView() {
       let  Vistorview = JYVistorView()
        view=Vistorview
        Vistorview.vistorViewDelegate=self
     //  view.backgroundColor = UIColor.grayColor()
        //设置导航栏按钮
  self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"注册", style: UIBarButtonItemStyle.Plain, target: self, action:  "vistorViewRegistClick")
    self.navigationItem.rightBarButtonItem=UIBarButtonItem(title: "登陆", style: UIBarButtonItemStyle.Plain, target: self, action:  "vistorViewloginClick")
        
        if self is JYHomeViewController {
            Vistorview.startRotationAnimation()
            // 监听应用退到后台,和进入前台
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "didEnterBackground", name: UIApplicationDidEnterBackgroundNotification, object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "didBecomeActive", name: UIApplicationDidBecomeActiveNotification, object: nil)
            

        }else if self is JYMessageViewController {
        Vistorview.setupVistorView("visitordiscover_image_message", message: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
        }else if self is JYDiscoverViewController {
        
        Vistorview.setupVistorView("visitordiscover_image_message", message: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
        }else if self is JYProfileViewController
        {
         Vistorview.setupVistorView("visitordiscover_image_profile", message: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
        
        }
        
        }
    
    ///MARK:-通知方法
    func didEnterBackground(){
    //暂停动画
    (view  as!  JYVistorView).pauseAnimation()
    }
    
    func didBecomeActive(){
    
        (view as! JYVistorView).resumeAnimation()
    
    }
  }

extension  JYBaseTableViewController: JYVistorViewDelegate {
    
    func vistorViewRegistClick() {
        print(__FUNCTION__ )
    }
    
    func vistorViewloginClick()  {
        // print(__FUNCTION__ )
        let controller = JYOauthViewController()
       
        presentViewController(UINavigationController(rootViewController: controller), animated: true, completion: nil)
  
    }

}




