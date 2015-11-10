//
//  JYStatus.swift
//  JYSinaWeibo
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit
import SDWebImage
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
    var pic_urls: [[String: AnyObject]]?{
        didSet {
            //// 当字典转模型,给pic_urls赋值的时候,将数组里面的url转成NSURL赋值给storePictureURLs
           //判断有没有图片
            let count = pic_urls?.count ?? 0
            
            //如果没有图片，直接返回
            if count == 0 {
            
            return
            
            }
          //创建storePictureURLs
            storePictureURLs = [NSURL]()
            
            for dict in pic_urls!{
            
                if let urlString = dict["thumbnail_pic"] as? String{
                
                //有URL地址
                    storePictureURLs?.append(NSURL(string: urlString)!)
                
                }
            }
        }
    }
    ///返回微博的配图对应URL的数组
     var storePictureURLs:[NSURL]? 
    /// 如果是原创微博,就返回原创微博的图片,如果是转发微博就返回被转发微博的图片
    /// 计算型属性,
    var pictureURLs: [NSURL]? {
        get {
            // 判断:
            // 1.原创微博: 返回 storePictureURLs
            // 2.转发微博: 返回 retweeted_status.storePictureURLs
            return retweeted_status == nil ? storePictureURLs : retweeted_status!.storePictureURLs
        }
    }

  
    /// 用户模型
    var user: JYUser?
    
    /// 缓存行高
    var rowHeight: CGFloat?
    
    ///被转发的微博
    var retweeted_status:JYStatus?
    func cellID() -> String {
        // retweeted_status == nil表示原创微博
        return retweeted_status == nil ? JYStatusCellIdentifier.NormalCell.rawValue : JYStatusCellIdentifier.ForwardCell.rawValue
    }

    
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
             user = JYUser(dict: dict)
            //一定要记得return
            return
            }
            }else  if key == "retweeted_status"{
                if let dict = value as? [String :AnyObject] {
                //字典装模型
                //被转发的微博
                    
                retweeted_status = JYStatus (dict:  dict )
                    
                }
                return
            
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
                // 缓存图片，通知调用者
             //   finished(statuses: statuses, error: nil)
                self.cacheWebImage(statuses, finished:finished)
            } else {
                // 没有数据,通知调用者
                finished(statuses: nil, error: nil)
            }

    
        }
    
    }
    
    class func cacheWebImage(statuses:[JYStatus]?,finished:(statuses:[JYStatus]?,error:NSError?)->()){
    
    //创建任务组
    let group = dispatch_group_create()
    //判断是否有模型
        guard let list = statuses else {
        
          //没有模型
            return
        
        }
        //记录缓存图片的大小
        var length = 0
        //遍历模型
        for status in list {
        
        //如果没有图片需要下载，接着遍历下一个
            let count = status.pictureURLs?.count ?? 0
            if  count == 0 {
             
            //没有图片遍历下一个模型
                continue
            }
         //判断是否有图片需要下载
            if let urls = status.pictureURLs{
            
            //有需要缓存的图片
                if urls.count == 1{
                
                let url = urls[0]
                 //缓存图片
                //在缓存之时放到任务组里面
                dispatch_group_enter(group)
               SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions(rawValue: 0), progress: nil , completed: { (image , error , _ , _ ,_ ) -> Void in
                //离开组
                dispatch_group_leave(group)
                
                  //判断有没有错误
                if error != nil {
                
                print("下载图片出错：\(url)")
                return
                }
                //没有出错
                print("下载图片完成:\(url )")
                
                
                //记录下载图片的大小
                if let data = UIImagePNGRepresentation(image){
                
                
                length += data.length
                
                }
                    })
                }
            
            }
        
        }
    //所有图片下载完，再通知调用者
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            //通知调用者，已经有数据了
            finished(statuses: statuses, error: nil )
        }
    }
}

