//
//  UIButton+Extension.swift
//  JYSinaWeibo
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import  UIKit
extension UIButton{
convenience init(imageName:String,title:String,titleColor:UIColor=UIColor.lightGrayColor(),fontSize:CGFloat=12){
  self.init()
    
setImage(UIImage(named: imageName), forState: UIControlState.Normal)
setTitle(title, forState: UIControlState.Normal)
setTitleColor(titleColor, forState: UIControlState.Normal)
titleLabel?.font=UIFont.systemFontOfSize(fontSize)




}
}