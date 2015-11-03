//
//  UILabel+Extension.swift
//  JYSinaWeibo
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit

///扩展Label
extension UILabel{
convenience init(fonsize:CGFloat,textColor:UIColor){

 //调用本类指定的构造函数
    self.init()
    
//设置文字的颜色
    self.textColor=textColor
    //设置文字的大小
    font = UIFont.systemFontOfSize(fonsize)


}
}