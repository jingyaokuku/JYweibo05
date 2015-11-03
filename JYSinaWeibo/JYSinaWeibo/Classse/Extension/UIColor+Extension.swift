//
//  UIColor+Extension.swift
//  JYSinaWeibo
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit

extension UIColor{


  //返回一个随机色
    class func randomColor() ->UIColor{
    
    
    return UIColor(red: randomValue(), green:randomValue() , blue: randomValue(), alpha: 1)
    
    
    
    }
    /// 随机 0 - 1 的值
    private class func randomValue() -> CGFloat {
        return CGFloat(arc4random_uniform(256)) / 255
    }



}
