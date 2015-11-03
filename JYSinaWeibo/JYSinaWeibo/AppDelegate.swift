//
//  AppDelegate.swift
//  JYSinaWeibo
//
//  Created by apple on 15/10/28.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      //创建window
       setupApppearance()
        window=UIWindow(frame:UIScreen.mainScreen().bounds )
        let tabar=JYMainController()
               //包装成根控制器
        window?.rootViewController=defaultController()
        //设置为主窗口并显示
        window?.makeKeyAndVisible()
        
        
      
        return true
    }
    private func defaultController() -> UIViewController{
    
    //判断是否需要登录
    //每次判断都需要 == nill
        if !JYUserAccout.userLogin(){
        return JYMainController()
        
        }
    //判断是不是新版本
      //  return isNewVersion() ? JYNewFeatureViewController() : JYWelcomeViewController()
        return  JYWelcomeViewController()
    
    }
    ///判断是不是新版本
    private func isNewVersion() -> Bool{
     
        //获取当前的版本号
        let versionString = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        let currentVersion=Double(versionString)!
        
        //获取到之前的版本号
        let sandboxVersionKey="sandboxVersionKey"
        let sanboxVersion=NSUserDefaults.standardUserDefaults().doubleForKey(sandboxVersionKey)
        
        
        //保存当前版本号
        NSUserDefaults.standardUserDefaults().setDouble(currentVersion, forKey: sandboxVersionKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    
       //对比
        return currentVersion > sanboxVersion
    
    }
    ///切换根控制器
    func switchRootController(isMain: Bool){
        window?.rootViewController=isMain ? JYMainController() : JYWelcomeViewController()
    
    }
    private    func setupApppearance() {
    
    UINavigationBar.appearance().tintColor=UIColor.orangeColor()
    
    
    }
}
