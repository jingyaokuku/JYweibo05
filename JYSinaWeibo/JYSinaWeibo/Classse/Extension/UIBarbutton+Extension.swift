//
//  UIBarbutton+Extension.swift
//  JYSinaWeibo
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit

extension UIBarButtonItem{

//扩展里只能是便利构造函数
    convenience init(imageName:String){
    
    
    let button = UIButton()
        
    button.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
    button.setImage(UIImage(named: "\(imageName)_highlighted"), forState: UIControlState.Highlighted)
    button.sizeToFit()
    self.init(customView:button)
    
    }

  ///不创建时候就调用，生成一个带按钮的UIBarButtonItem
    
    class func navigationItem(imageName:String) -> UIBarButtonItem{
    
    let button = UIButton()
    button.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
    button.setImage(UIImage(named: "\(imageName)_highlighted"), forState: UIControlState.Highlighted)
    button.sizeToFit()
   return UIBarButtonItem(customView: button)
    
    
    }


}