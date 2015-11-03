//
//  JYVistorView.swift
//  JYSinaWeibo
//
//  Created by apple on 15/10/28.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit

//定义协议 
 protocol  JYVistorViewDelegate: NSObjectProtocol {

   func vistorViewRegistClick()
   func vistorViewloginClick()
}

class JYVistorView: UIView {
    
    //属性
    weak var vistorViewDelegate: JYVistorViewDelegate?
    
    
    ///MARK:- 按钮点击事件
    func registClick(){
    
        vistorViewDelegate?.vistorViewRegistClick()
    
    }
  //登陆
    func loginClick(){
    
    vistorViewDelegate?.vistorViewloginClick()
    
    }
    // MARK: - 构造函数
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init (frame:CGRect)
    {
        super.init(frame: frame)
     
    
        
     prepareUI()
    }
    /**
     创建访客视内容
     */
    func setupVistorView(imageName:String,message:String) {
    
    //隐藏房子
        homeView.hidden=true
        iconView.image=UIImage(named: imageName)
       textLabel.text=message
        
        self.sendSubviewToBack(coverView)
        
    
    }
    func startRotationAnimation() {
        // 创建动画
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        // 设置参数
        animation.toValue = 2 * M_PI
        animation.repeatCount = MAXFLOAT
        animation.duration = 20
        
        // 完成的时候不移除
        animation.removedOnCompletion = false
        
        // 开始动画
        iconView.layer.addAnimation(animation, forKey: "homeRotation")
    }
    
    /// 暂停旋转
    func pauseAnimation() {
        // 记录暂停时间
        let pauseTime = iconView.layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        
        // 设置动画速度为0
        iconView.layer.speed = 0
        
        // 设置动画偏移时间
        iconView.layer.timeOffset = pauseTime
    }
    
    /// 恢复旋转
    func resumeAnimation() {
        // 获取暂停时间
        let pauseTime = iconView.layer.timeOffset
        
        // 设置动画速度为1
        iconView.layer.speed = 1
        
        iconView.layer.timeOffset = 0
        
        iconView.layer.beginTime = 0
        
        let timeSincePause = iconView.layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pauseTime
        
        iconView.layer.beginTime = timeSincePause
    }

///准备UI
    func  prepareUI() {
    backgroundColor = UIColor(white: 237.0 / 255, alpha: 1)

    
     addSubview(iconView)
    addSubview(coverView)
     addSubview(homeView)
     addSubview(textLabel)
    addSubview(registerButton)
    addSubview(longinButton)
    
    
   //设置约束
        iconView.translatesAutoresizingMaskIntoConstraints=false
        homeView.translatesAutoresizingMaskIntoConstraints=false
        textLabel.translatesAutoresizingMaskIntoConstraints=false
        registerButton.translatesAutoresizingMaskIntoConstraints=false
        longinButton.translatesAutoresizingMaskIntoConstraints=false
        coverView.translatesAutoresizingMaskIntoConstraints=false
    
        
    //创建约束
    //转轮
    //centerX
       self.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
     //centerY
      self.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
       ///小房子
        //centerX
       self.addConstraint(NSLayoutConstraint(item: homeView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
         //centerY
       self.addConstraint(  NSLayoutConstraint(item: homeView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        ///文字
         //centerX
        self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        //y
     self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 16))
        //witch
     self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 240))
        ///注册按钮
        //左边
       addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: textLabel, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0))
        //顶部
      addConstraint( NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: textLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        //宽度
      addConstraint(  NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100))
        
       addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 35))
        ///登陆按钮
        //左边
        addConstraint(NSLayoutConstraint(item: longinButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: textLabel, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0))
        //顶部
        addConstraint( NSLayoutConstraint(item: longinButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: textLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        //宽度
        addConstraint(  NSLayoutConstraint(item: longinButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100))
        
        addConstraint(NSLayoutConstraint(item: longinButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 35))
        // 遮盖
        // 左边
        addConstraint(NSLayoutConstraint(item: coverView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0))
        
        // 上边
        addConstraint(NSLayoutConstraint(item: coverView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        
        // 右边
        addConstraint(NSLayoutConstraint(item: coverView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0))
        
        // 下边
        addConstraint(NSLayoutConstraint(item: coverView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: registerButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        
}

    
    
    
    
    
///MARK---懒加载
//转轮
 private  lazy var  iconView: UIImageView = {

   let imageView = UIImageView()
    
   //设置图片
    let image=UIImage(named: "visitordiscover_feed_image_smallicon")
    
    imageView.image=image
    imageView.sizeToFit()
    
   return imageView
  

}()

 ///小房子，只在首页设置
    
    
    private  lazy var  homeView: UIImageView = {
        
        let imageView = UIImageView()
        
        //设置图片
        let image=UIImage(named: "visitordiscover_feed_image_house")
        
        imageView.image=image
        imageView.sizeToFit()
        
        return imageView
        
        
    }()
    
///设置文子
   private lazy var  textLabel:UILabel={
    
    
    let textLabel=UILabel()
    textLabel.text="关注一些人,看看有什么惊喜"
    textLabel.textColor=UIColor.lightGrayColor()
    textLabel.numberOfLines=0
    textLabel.sizeToFit()
    
    return textLabel
    }()
    
  //登陆按钮
   private lazy var longinButton : UIButton={
    
     let button=UIButton()
    
    button.setTitle("登陆", forState: UIControlState.Normal)
    //设置字体颜色
    
    button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    
    //设置背景
    button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
    
    
    button.sizeToFit()
    //添加点击事件
     button.addTarget(self , action: "loginClick", forControlEvents: UIControlEvents.TouchUpInside)
    return button
    }()
    //注册按钮
    private lazy var registerButton : UIButton={
        
        let button=UIButton()
        
        button.setTitle("注册", forState: UIControlState.Normal)
        //设置字体颜色
        
        button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        
        //设置背景
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        
        
        button.sizeToFit()
     
       
        return button
    }()

    // 遮盖
    private lazy var coverView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
}



