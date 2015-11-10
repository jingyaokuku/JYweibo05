//
//  JYRefreshControl.swift
//  JYSinaWeibo
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit

class JYRefreshControl: UIRefreshControl {

   //MARK - 属性
    ///MARk- 构造函数
    override init (){
    
    super.init()
    prepareUI()
      
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    ///MARK - 准备UI
    private func prepareUI(){
    //添加子控件
        addSubview(refreshView)
        print("refreshView:\(refreshView)")
        //添加约束
        refreshView.ff_AlignInner(type: ff_AlignType.CenterCenter, referView: self, size: refreshView.bounds.size)
    
    
    }
    //MARK - 懒加载控件
    private lazy var refreshView:JYRefreshView = JYRefreshView.refreshView()
}
//自定义刷新的View
class  JYRefreshView:UIView{

   //箭头

    @IBOutlet weak var tipView: UIImageView!
    
    //加载xib
   class  func refreshView ()->JYRefreshView{

    
    return NSBundle.mainBundle().loadNibNamed("JYRefresh", owner: nil, options: nil ).last as! JYRefreshView
    
    }



}