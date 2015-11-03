//
//  JYHomeTitleButton.swift
//  JYSinaWeibo
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit

class JYHomeTitleButton: UIButton {
    
    override func layoutSubviews(){
    super.layoutSubviews()
     
    //改变箭头的位置
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x=titleLabel!.frame.width+3
    
    
    
    }

}
