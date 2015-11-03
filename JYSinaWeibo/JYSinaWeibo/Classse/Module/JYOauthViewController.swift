//
//  JYOauthViewController.swift
//  JYSinaWeibo
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit
import SVProgressHUD
class JYOauthViewController: UIViewController {
    
     override func loadView() {
        view = webView
        //设置代理 
        webView.delegate=self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

       navigationItem.rightBarButtonItem=UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        
        //加载网页
        let request = NSURLRequest(URL: JYNetworkTools.sharedInstance.oauthRUL())
        
        webView.loadRequest(request)
    
    }
    ///关闭控制器
    func close() {
     SVProgressHUD.dismiss()
     dismissViewControllerAnimated(true , completion: nil )
    }
   //懒加载
    private lazy var webView=UIWebView()
}
///MARK: -扩展CZOauthViewController 实现 UIWebViewDelegate 协议

extension JYOauthViewController: UIWebViewDelegate{

    
    //开始加载请求
    func webViewDidStartLoad(webView: UIWebView) {
        //显示正在加载
        SVProgressHUD.showWithStatus("正在努力加载",maskType: SVProgressHUDMaskType.Black)
    }

  ///加载请求完毕
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }

  //询问是否加载request
   //这个方法就是webview的加载的代理方法
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let urlString = request.URL!.absoluteString
        
        //加载的不是回调的地址
        if !urlString.hasPrefix(JYNetworkTools.sharedInstance.redirect_uri){
        
            return true  //可以加载
            
        
        }
        //如果点击的确定或者取消拦截不加载
        if let query = request.URL?.query{
            print("到了是否授")
            let codeString = "code="
            
            if query.hasPrefix(codeString){
            
            
            let nsQuery = query as NSString
                
            //截取code的值
            let code = nsQuery.substringFromIndex(codeString.characters.count)
             //获取access token
              loadAccessToken(code)
            }else
            {
            //取消
            
            }
        
        }
        return false
    }
    
    /**
    *  调用网络工具类去加载access token
    */
    func  loadAccessToken(code: String){
    
        JYNetworkTools.sharedInstance.loadAccessToken(code){(result,error) -> () in
            
            if error != nil || result == nil {
            self.netError("网络不给力...")
                return
            }
        
            let  account = JYUserAccout(dict: result!)
            
           //保存到沙盒
            account.saveAccount()
            
            //加载用户数据
            account.loadUserInfo({(error) -> () in
                
                if error != nil {
                //加载用户数据出错
                self.netError("加载用户数据出错...")
                    return
                }
                 self.close()
                    
                 //切换控制器
              //  ( UIApplication.sharedApplication().delegate as! AppDelegate).
                
                })
            }
    }
    
    private func netError(message: String) {
        SVProgressHUD.showErrorWithStatus(message, maskType: SVProgressHUDMaskType.Black)
        
        // 延迟关闭. dispatch_after 没有提示,可以拖oc的dispatch_after来修改
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), { () -> Void in
            self.close()
        })
    }


}









