//
//  JYStatusForwardCell.swift
//  JYSinaWeibo
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit

class JYStatusForwardCell:JYStatuscell {

  //覆盖父类的模型属性
  override  var status: JYStatus?{
    
    didSet {
    
        let name = status?.retweeted_status?.user?.name ?? "名称为空"
        let text = status?.retweeted_status?.text ?? "内容为空"
        
        forwardLabel.text = "@\(name):\(text)"
    
    
    }

    }
    
 /// 覆盖父类的方法
    override func prepareUI(){
    
    ///记得调用父类方法
        super.prepareUI()
        
        //添加子控件
        contentView.insertSubview(bkgButton, belowSubview: pictureView)
        print("pictureVIEW:\(pictureView)")
        contentView.addSubview(forwardLabel)
        //添加约束
        //左上角的约束
        bkgButton.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: nil , offset: CGPoint(x: -StatusCellMargin, y: StatusCellMargin))
        //右下角
        bkgButton.ff_AlignVertical(type: ff_AlignType.TopRight, referView: bottomView, size: nil)
        //被转发的微博内容label
        forwardLabel.ff_AlignInner(type: ff_AlignType.TopLeft, referView: bkgButton, size: nil ,offset: CGPoint(x: StatusCellMargin, y: StatusCellMargin))
        //宽度约束
        contentView.addConstraint(NSLayoutConstraint(item: forwardLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: UIScreen.width() - 2*StatusCellMargin))
        //配图的约束
        let cons = pictureView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: forwardLabel, size: CGSize(width: 0, height: 0), offset: CGPoint(x: 0, y: StatusCellMargin))
        
        //获取配图的宽高约束
        pictureViewHeightCon = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Height)
        pictureViewWidthCon = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Width)
}
    
    /**
    *  懒加载
    */
    
    ///灰色的背景
    private lazy var bkgButton: UIButton = {
     
        let button = UIButton()
        
        //设置背景
        button.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        
       return button
    
    
    }()
    
    ///被转发的内容
    private lazy var forwardLabel: UILabel = {
    
     let label = UILabel()
        
    label.textColor = UIColor.darkGrayColor()
    label.numberOfLines = 0
    label.text = "我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试"
    return label
     
    }()

}
