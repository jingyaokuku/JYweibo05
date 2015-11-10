//
//  JYHomeViewController.swift
//  JYSinaWeibo
//
//  Created by apple on 15/10/28.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit
import AFNetworking
import  SVProgressHUD

//统一管理的cellID 
enum JYStatusCellIdentifier:String{

    case   NormalCell = "NormalCell"
    
    case  ForwardCell = "ForwardCell"
    


}

class JYHomeViewController: JYBaseTableViewController {
  ///MARK:- 属性
  ///微博模型数组
    private var statuses: [JYStatus]?{
        didSet {
        
          tableView.reloadData()
        
        }
    
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if !JYUserAccout.userLogin(){
        
        return
        }
        
        setupNavigationBar()
        prepareTableView()
        
        refreshControl = JYRefreshControl()
        //加载微博数据
        print("加载微博数据")
        JYStatus.loadStatus { (statuses, error) -> () in
            if error != nil {
            
                SVProgressHUD.showErrorWithStatus("加载网络数据失败，网络不给力", maskType: SVProgressHUDMaskType.Black)
                
                return
            
            
            }
            //能到下下面来说明没有错误
            if statuses == nil || statuses?.count == 0{
            
            SVProgressHUD.showErrorWithStatus("没有新的微博", maskType: SVProgressHUDMaskType.Black)
                return
            
            }
            //有微博数据
            
            self.statuses = statuses
           // print("statues:\(statuses)")
        }
    }
    private func prepareTableView() {
        //tableView注册cell
        //原创微博cell
//        tableView.registerClass(JYStatuscell.self , forCellReuseIdentifier: "cell")
         tableView.registerClass(JYStatusNormalCell.self, forCellReuseIdentifier: JYStatusCellIdentifier.NormalCell.rawValue)
        
        //注册转发微博
        tableView.registerClass(JYStatusForwardCell.self, forCellReuseIdentifier: JYStatusCellIdentifier.ForwardCell.rawValue)
        //去掉tableView 的分割线
        tableView.separatorStyle=UITableViewCellSeparatorStyle.None
        
//        tableView.estimatedRowHeight=300
//        
//        tableView.rowHeight=UITableViewAutomaticDimension
        
    }
    
    ///设置导航栏
    private func setupNavigationBar(){
    navigationItem.leftBarButtonItem=UIBarButtonItem(imageName: "navigationbar_friendsearch")
        
    navigationItem.rightBarButtonItem=UIBarButtonItem(imageName: "navigationbar_pop")
        
        
    let name=JYUserAccout.loadAccount()?.name ?? "没有名称"
    //设置title
    let button=JYHomeTitleButton()
    
    button.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
    button.setTitle(name, forState: UIControlState.Normal)
    button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    button.sizeToFit()
    button.addTarget(self , action: "homeButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
    navigationItem.titleView=button
    
    }
    
    //oc可以访问private方法
  
    @objc private func homeButtonClick(button:UIButton){
    button.selected = !button.selected
        var transform: CGAffineTransform?
        if button.selected{
        transform=CGAffineTransformMakeRotation(CGFloat(M_PI - 0.01))

        }else{
        
        
        transform=CGAffineTransformIdentity//表示旋转回到原来的位置
        }
        
        UIView.animateWithDuration(0.25) { () -> Void in
            button.imageView?.transform=transform!
        }
        }
    
      ///MARK : tableView 的代理和数据源
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //获取模型
        let status = statuses![indexPath.row]
        
        //去模型里面看是否有缓存得行高
        if let rowHeight = status.rowHeight{
        
        return rowHeight
        
        }
        //没有缓存的行高
        let id = status.cellID()
        //获取cell
        let cell = tableView.dequeueReusableCellWithIdentifier(id) as! JYStatuscell
        
        //调用计算行高的方法
       let rowHeight = cell.rowHeight(status)
        
        //将行高缓存起来
        status.rowHeight = rowHeight
        
        return rowHeight
       
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let status = statuses![indexPath.row]
        // 获取cell
        let cell = tableView.dequeueReusableCellWithIdentifier(status.cellID()) as! JYStatuscell
        
        // 设置cell的模型
        cell.status = statuses?[indexPath.row]
        
        return cell
    }
   }
