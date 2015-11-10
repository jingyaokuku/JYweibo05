//
//  JYStatusBottomView.swift
//  JYSinaWeibo
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit

class JYStatusBottomView: UIView {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //设置背景颜色
        backgroundColor = UIColor(white: 0.93, alpha: 1)
        
        prepareUI()
        
    }
 ///准备UI
    private func prepareUI() {
        //添加子控件
       addSubview(forwardButton)
        addSubview(commenButton)
        addSubview(lickButton)
        addSubview(separatorViewOne)
        addSubview(separatorViewTwo)
        
        //添加约束
        self.ff_HorizontalTile([forwardButton,commenButton,lickButton], insets: UIEdgeInsetsZero)
        
        //分割线1
        separatorViewOne.ff_AlignHorizontal(type: ff_AlignType.CenterRight, referView: forwardButton, size: nil)
        
        //分割线2
        separatorViewTwo.ff_AlignHorizontal(type: ff_AlignType.CenterRight, referView: commenButton, size: nil )
    }
    /**
    * 懒加载控件
    */
    //转发
    private  lazy  var   forwardButton: UIButton = UIButton(imageName: "timeline_icon_retweet", title: "转发")
    
    //评论
    private lazy var commenButton: UIButton = UIButton(imageName: "timeline_icon_comment", title: "评论")
    
    // 赞
    private lazy var  lickButton: UIButton = UIButton(imageName: "timeline_icon_unlike", title: "赞")
    
    //水平分割线1
    private lazy var separatorViewOne:UIImageView = UIImageView(image: UIImage(named: "timeline_card_bottom_line_highlighted"))
    //水平分割线2
    private lazy var separatorViewTwo:UIImageView = UIImageView(image: UIImage(named: "timeline_card_bottom_line_highlighted"))
}
