//
//  JYUserAccout.swift
//  JYSinaWeibo
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit

class JYUserAccout: NSObject,NSCoding {
    //账号就返回true
   class  func userLogin() -> Bool{
    
    return JYUserAccout.loadAccount() != nil
        
}
    /// 用于调用access_token，接口获取授权后的access token
    var access_token: String?
    
    /// access_token的生命周期，单位是秒数
    /// 对于基本数据类型不能定义为可选
    var expires_in: NSTimeInterval = 0 {
        didSet {
            expires_date = NSDate(timeIntervalSinceNow: expires_in)//有效时间，通过换算秒数来换成距离现在还有多少时间
            print("expires_date:\(expires_date)")
        }
    }
    
    /// 当前授权用户的UID
    var uid: String?
    
    /// 过期时间
    var expires_date: NSDate?
    
    /// 友好显示名称
    var name: String?
    
    /// 用户头像地址（大图），180×180像素
    var avatar_large: String?
    
    // KVC 字典转模型
    init(dict: [String: AnyObject]) {
        
        super.init()
        // 将字典里面的每一个key的值赋值给对应的模型属性
        setValuesForKeysWithDictionary(dict)
    }
    
    // 当字典里面的key在模型里面没有对应的属性
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override var description: String {
        return "access_token:\(access_token), expires_in:\(expires_in), uid:\(uid): expires_date:\(expires_date), name:\(name), avatar_large:\(avatar_large)"
    }

    ///加载用户的信息
    //控制器调用这个方法，不管是否成功都要告诉调用者
    //finish:(error:NSError?) ->()是一个闭包写在函数方法里面就不需要in
    
   //记得
    func loadUserInfo(finish:(error:NSError?) ->()) {
    
        JYNetworkTools.sharedInstance.loadUserInfo{(result ,error ) ->() in
            
            if error != nil || result == nil {
             finish(error: error)
                return
            
            }
        //加载成功
            
            self.name=result!["name"] as? String
            self.avatar_large=result!["avatar_large"] as? String
            
            //保存到沙盒
            
            self.saveAccount()
            
            
            //同步到内存中，把当前的对象赋值给内存中的 userAccount
            
         JYUserAccout.userAccount=self
            finish(error: nil )
        
        }
    
    }
    
    
    
    
    
    static let accountPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true ).last!+"/Account.plist"
    //保存对象
    func saveAccount(){
    //归档
    NSKeyedArchiver.archiveRootObject(self , toFile: JYUserAccout.accountPath)
    
    }
    
    
    
    
    //类属性访问属性需要将属性定义成static
    private static var userAccount :JYUserAccout?
    
class func loadAccount()-> JYUserAccout?{
     //判断内存有没有 
        if userAccount == nil{
        
        //解档给内存中的账号
         userAccount = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? JYUserAccout
        
        }
    if userAccount != nil && userAccount?.expires_date?.compare(NSDate()) == NSComparisonResult.OrderedDescending {
      //  print("账号有效")
        return userAccount
    }

    
    return nil
    
    }
    // MARK: - 归档和解档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
    }
    
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeDoubleForKey("expires_in")
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
        name = aDecoder.decodeObjectForKey("name") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
    }

}
