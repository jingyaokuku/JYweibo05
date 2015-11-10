//
//  JYStatusNormalCell.swift
//  JYSinaWeibo
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit

class JYStatusNormalCell: JYStatuscell {
 //原创的微博的cell
    override func prepareUI() {
        super.prepareUI()
        
        let cons = pictureView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: CGSize(width: 0, height: 0), offset: CGPoint(x: 0, y: StatusCellMargin) )
        
        
        //获取配图的宽高的约束
        pictureViewHeightCon = pictureView.ff_Constraint(cons , attribute: NSLayoutAttribute.Height)
        pictureViewWidthCon = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Width)
    }
  
}
