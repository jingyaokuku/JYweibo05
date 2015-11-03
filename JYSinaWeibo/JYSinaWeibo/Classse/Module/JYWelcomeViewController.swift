
//
//  JYWelcomeViewController.swift
//  JYSinaWeibo
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit
import SDWebImage
class JYWelcomeViewController: UIViewController {
    
    ///MArk :- 属性
    ///头像底部约束
    private var iconViewBottomCons:NSLayoutConstraint?

    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        //准备UI
        prepareUI()
        
        if let urlString = JYUserAccout.loadAccount()?.avatar_large{
        //设置用户头像
            iconView.sd_setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "avatar_default_big"))
           
        
        }

    }
    /**
     制作头像动画
     */
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //开始动画
        iconViewBottomCons?.constant = -(UIScreen.mainScreen().bounds.height - 160)
        // usingSpringWithDamping: 值越小弹簧效果越明显 0 - 1
        // initialSpringVelocity: 初速度
        UIView.animateWithDuration(1.0, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            self.view.layoutIfNeeded()
            }) { (_ ) -> Void in
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.welcomeLable.alpha=1
                    }, completion: { (_ ) -> Void in
                        (UIApplication.sharedApplication().delegate as! AppDelegate).switchRootController(true )
                })
        }
    }
  ///准备UI
    
    private func prepareUI(){
    
    //添加子控件
    view.addSubview(backgroudImageView)
     view.addSubview(iconView)
    view.addSubview(welcomeLable)
        
        //添加约束
        backgroudImageView.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        welcomeLable.translatesAutoresizingMaskIntoConstraints = false
        
        //填充父控件
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[bkg]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["bkg" :backgroudImageView]))
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[bkg]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["bkg" :backgroudImageView]))
        //头像
        view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 85))
        view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 85))
        //垂直底部
        iconViewBottomCons = NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -160)
        view.addConstraint(iconViewBottomCons!)
        
        //欢迎归来
        //H
        view.addConstraint(NSLayoutConstraint(item: welcomeLable, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: welcomeLable, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 16))
        
    
    }
    
  ///MARK -懒加载
    //背景
    private lazy var backgroudImageView: UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    //头像
    private lazy var iconView: UIImageView = {
    
    let imageView = UIImageView(image: UIImage(named: "avatar_default_big"))
        //切成圆
        imageView.layer.cornerRadius=42.5
        imageView.layer.masksToBounds=true//这两个属性配合使用来去切圆角
        
        
        return imageView
    
    }()
    
   ///欢迎归来
    private lazy var welcomeLable: UILabel = {
     
        let label = UILabel()
        
        label.text = "欢迎归来"
    
        label.alpha=0
        
        return label
      }()
    
}
