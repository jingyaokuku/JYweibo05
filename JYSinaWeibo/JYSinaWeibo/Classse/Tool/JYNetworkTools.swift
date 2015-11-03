//
//  JYNetworkTools.swift
//  JYSinaWeibo
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit
import AFNetworking

//MARK :- 网络错误枚举
enum JYNetworkErrror: Int{

case emptyToken = -1
case emptyUid = -2
//枚举里可以有属性
    var description: String{
        get {
        
        //根据枚举的类型返回对应的错误
            switch self{
            case JYNetworkErrror.emptyToken:
                return "accecc token 为空"
            case JYNetworkErrror.emptyUid:
                return "uid 为空"
            
            }
        }
    }
    //枚举可以定义方法
    func error() ->NSError{
    
    return NSError(domain:  "cn.itcast.error.network", code: rawValue, userInfo: ["errorDescription" : description])
    }

}
class JYNetworkTools: NSObject{

    //属性
    private var afnManager:AFHTTPSessionManager
    
    //创建单例
    static let sharedInstance:JYNetworkTools=JYNetworkTools()
    
    override init(){
    
    let urlString="https://api.weibo.com/"
    afnManager=AFHTTPSessionManager(baseURL: NSURL(string: urlString))
    afnManager.responseSerializer.acceptableContentTypes?.insert("text/plain")
    
    }
    //MARK --Oauth授权
    ///申请应用时分配的appkey 
    private let client_id = "1355617602"
    
    //申请时应用分配的AppSecret
    private let client_secret="4b5f948a59ed200626890070ba5b8ddd"
    
    ///回调地址
    let  redirect_uri="http://www.baidu.com"
    
    /// 请求的类型，填写authorization_code
    private let grant_type = "authorization_code"
    
    // OAtuhURL地址
    func oauthRUL()->NSURL{
    
    let urlString="https://api.weibo.com/oauth2/authorize?client_id=\(client_id)&redirect_uri=\(redirect_uri)"
        
    return NSURL(string: urlString)!
    
    }
    
    
    //使用闭包回调
    //MARK: -加载AccessToken
    /**
    *  加载AccessToken
    */
    func loadAccessToken(code:String,finished:NetworkFinishedCallback){
    
    let urlString="oauth2/access_token"
        
        
        // NSObject
        // AnyObject, 任何 class
        // 参数
        let parameters = [
            "client_id": client_id,
            "client_secret": client_secret,
            "grant_type": grant_type,
            "code": code,
            "redirect_uri": redirect_uri
        ]
        // result: 请求结果
        afnManager.POST(urlString, parameters: parameters, success: { (_, result ) -> Void in
            finished(result:result as? [String : AnyObject], error: nil  )
            }) { (_, error:NSError ) -> Void in
                finished(result: nil , error: error )
        }
    }
    // MARK: - 获取用户信息
    func loadUserInfo(finshed: NetworkFinishedCallback) {
        // 判断accessToken
      //  if JYUserAccout.loadAccount()?.access_token == nil {
        guard var parameters = tokenDict() else{
            print("没有accessToken")
        let error = JYNetworkErrror.emptyToken.error()
        
         finshed(result: nil , error: error)
            return
        }
        
        // 判断uid
        if JYUserAccout.loadAccount()?.uid == nil {
            print("没有uid")
            let error = JYNetworkErrror.emptyUid.error()
            
            // 告诉调用者
            finshed(result: nil, error: error)
            return
        }
        
        // url
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        // 参数
//        let parameters = [
//            "access_token": JYUserAccout.loadAccount()!.access_token!,
//            "uid": JYUserAccout.loadAccount()!.uid!
//        ]
        // 添加元素
        parameters["uid"] = JYUserAccout.loadAccount()!.uid!
        requestGET(urlString, parameters: parameters, finished: finshed)
    
}
    /// 判断access token是否有值,没有值返回nil,如果有值生成一个字典
    func tokenDict() -> [String: AnyObject]? {
        if JYUserAccout.loadAccount()?.access_token == nil {
            return nil
        }
        
        return ["access_token": JYUserAccout.loadAccount()!.access_token!]
    }
  ///MARK: 获取微博数据
    func loadStautus(finished: NetworkFinishedCallback) {
        guard let parameters = tokenDict() else {
            // 能到这里来说明token没有值
            
            // 告诉调用者
            finished(result: nil, error: JYNetworkErrror.emptyToken.error())
            return
        }
        // access token 有值
        let urlString = "2/statuses/home_timeline.json"
        // 网络不给力,加载本地数据
        //        loadLocalStatus(finished)
        requestGET(urlString, parameters: parameters, finished: finished)
    
    
    }
    
    private func loadLocalStatus(finished: NetworkFinishedCallback) {
        // 获取路径
        let path = NSBundle.mainBundle().pathForResource("statuses", ofType: "json")
        
        // 加载文件数据
        let data = NSData(contentsOfFile: path!)
        
        // 转成json
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
            // 有数据
            finished(result: json as? [String : AnyObject], error: nil)
        } catch {
            print("出异常了")
        }
    }

    /**
    *  定义宏
    */
    typealias NetworkFinishedCallback=(result:[String:AnyObject]?,error:NSError?) ->()
    
     // MARK: - 封装AFN.GET
    
    
    func requestGET(URLString: String, parameters: AnyObject?, finished: NetworkFinishedCallback)  {
    
     afnManager.GET(URLString, parameters: parameters, success: { (_, result ) -> Void in
        finished(result: result  as? [String:AnyObject], error: nil )
        }) { (_ , error ) -> Void in
            finished(result :nil , error:error )
        }
    
    }
}
