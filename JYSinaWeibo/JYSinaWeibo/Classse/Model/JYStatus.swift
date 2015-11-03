//
//  JYStatus.swift
//  JYSinaWeibo
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit

class JYStatus: NSObject {
    
    ///微博创建的时间

    var created_at: String?
    
    /// 字符串型的微博ID
    var idstr: String?
    
    /// 微博信息内容
    var text: String?
    
    /// 微博来源
    var source: String?
    
    /// 微博的配图
    var pic_urls: [[String: AnyObject]]?
    
    /// 用户模型
    var user: JYUser?
    
    /// 缓存行高
    var rowHeight: CGFloat?
    
    /// 字典转模型
    init(dict: [String: AnyObject]) {
        super.init()
        
        // 回调用 setValue(value: AnyObject?, forKey key: String) 赋值每个属性
        setValuesForKeysWithDictionary(dict)
    }
    //kvc赋值每一个属性时都会调用
    override func setValue(value: AnyObject?, forKey key: String) {
        //判断user赋值时，自己字典转模型
        if key == "user"{
            //使用值绑定转换字典类型
            if let dict = value as?[String:AnyObject]{
            //字典转模型
            //赋值
            
            //一定要记得return
            return
            
            }
        }
        return super.setValue(value, forKey: key)
    }
    
    //字典的key在模型中找不到对应的属性时候
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
     override var description: String {
    
        let p = ["created_at", "idstr", "text", "source", "pic_urls", "user"]
        // 数组里面的每个元素,找到对应的value,拼接成字典
        // \n 换行, \t table
        return "\n\t微博模型:\(dictionaryWithValuesForKeys(p))"
}
    
    ///加载微博数据
    ///没有模型对象就能加载数据 所以用类方法
    class func loadStatus(finished:(statuses:[JYStatus]?,error:NSError?) ->()){
    
        JYNetworkTools.sharedInstance.loadStautus {(result ,error) ->() in
        
            if error != nil {
            
            //通知调用者
            finished(statuses: nil , error: error)
                
                return
            }
            if let array = result?["statuses"] as? [[String: AnyObject]] {
                // 有数据
                // 创建模型数组
                var statuses = [JYStatus]()
                
                for dict in array {
                    // 字典转模型
                    statuses.append(JYStatus(dict: dict))
                }
                
                // 字典转模型完成
                // 通知调用者
                finished(statuses: statuses, error: nil)
            } else {
                // 没有数据,通知调用者
                finished(statuses: nil, error: nil)
            }

    
        }
    
    }
    
    
}
