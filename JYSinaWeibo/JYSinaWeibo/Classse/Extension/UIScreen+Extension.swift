//
//  UIScreen+Extension.swift
//  JYSinaWeibo
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit

extension UIScreen{

//提供直接返回屏幕高度
    class func height() -> CGFloat{
    
    return UIScreen.mainScreen().bounds.height
    
    }

//提供直接返回屏幕宽度
    class func width () -> CGFloat{
    
    return UIScreen.mainScreen().bounds.width
    
    
    }



}
