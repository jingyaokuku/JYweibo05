//
//  JYStatuscell.swift
//  JYSinaWeibo
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit
let StatusCellMargin: CGFloat = 8
class JYStatuscell: UITableViewCell {
   
    //MARK : -属性
    //配图的宽度约束
    
    private var pictureViewWidthCon:NSLayoutConstraint?
    
    //配图的高度约束
    private var pictureViewHeightCon:NSLayoutConstraint?
    
    ///微博模型
    var status:JYStatus?{
        didSet{
        
        //将模型赋值给topView
        
        
        
        
        }
    
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

   ///MARK :--懒加载
    //顶部视图
    private lazy var topView: JYStatus
}
