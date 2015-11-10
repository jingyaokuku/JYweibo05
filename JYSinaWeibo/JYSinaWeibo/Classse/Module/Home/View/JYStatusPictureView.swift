//
//  JYStatusPictureView.swift
//  JYSinaWeibo
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 Jingyao. All rights reserved.
//

import UIKit
import  SDWebImage
class JYStatusPictureView: UICollectionView {
    
    ///MARK: -属性
    //cell重用标示
    private let StatusPictureViewIdentifier = "StatusPictureViewIdentifier"
   
    //微博模型
    var status: JYStatus?{
    
        didSet {
        
        reloadData()//更新数据
        
        }
    }
    //这个方法是sizeToFit调用的,而且 返回的 CGSize 系统会设置为当前view的size
    override func sizeThatFits(size: CGSize) -> CGSize {
        return calcViewSize()
    }
    //根据微博模型，计算配图的尺寸
    
    func  calcViewSize() -> CGSize {
    //itemSize
        let itemSize = CGSize(width: 90, height: 90)
        
        //设置itemSize
        layout.itemSize=itemSize
        layout.minimumInteritemSpacing=0
        layout.minimumLineSpacing=0
        
        //间距
        let margin:CGFloat = 10
        
        //列数
        let column = 3
        
        //根据模型的图片数量来计算尺寸
        let count = status?.pictureURLs?.count ?? 0
        //没有图片
        if count == 0{
        
        
        return CGSizeZero
        }
        if count == 1{
        //获取图片的URL路径
        let urlString = status!.pictureURLs![0].absoluteString
        //获取缓存好的图片，缓存的图片可能没有成功
        let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(urlString)
        var  size = CGSize(width: 150, height: 120)
            
        //当有图片的时候来赋值
            if image != nil{
            
            size = image.size
            
            }
        layout.itemSize = size
         return size
        
        }
        layout.minimumInteritemSpacing = margin
        layout.minimumLineSpacing = margin
        
        //4张图片时
        if count == 4{
          let width = 2*itemSize.width + margin
         return CGSize(width: width, height: width)
        
        }
        // 剩下 2, 3, 5, 6, 7, 8, 9
        // 计算行数: 公式: 行数 = (图片数量 + 列数 -1) / 列数
        let row = (count + column - 1) / column
        
        // 宽度公式: 宽度 = (列数 * item的宽度) + (列数 - 1) * 间距
        let widht = (CGFloat(column) * itemSize.width) + (CGFloat(column) - 1) * margin
        
        // 高度公式: 高度 = (行数 * item的高度) + (行数 - 1) * 间距
        let height = (CGFloat(row) * itemSize.height) + (CGFloat(row) - 1) * margin
        
        return CGSize(width: widht, height: height)

    }
  //布局
    private var layout = UICollectionViewFlowLayout()
    
    init(){
        super.init(frame: CGRectZero,collectionViewLayout:layout)
        
        //设置背景
        backgroundColor = UIColor.clearColor()
        
        //设置数据源
        
        dataSource = self
        //注册cell(创建)
        
        registerClass(JYStatusPictureViewCell.self , forCellWithReuseIdentifier: StatusPictureViewIdentifier)
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - 扩展 CZStatusPictureView 类,实现 UICollectionViewDataSource协议
extension JYStatusPictureView: UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return status?.pictureURLs?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(StatusPictureViewIdentifier, forIndexPath: indexPath) as! JYStatusPictureViewCell
        
      //  let url = status?.pic_urls?[indexPath.item]["thumbnail_pic"]as?String
        
        cell.imageURL = status?.pictureURLs?[indexPath.item]
        
        return cell
    }
    
    
}

    //自定义cell显示图片
    class JYStatusPictureViewCell :UICollectionViewCell {
        ///MARK: - 属性
        var imageURL:NSURL?{
        
            didSet {
            //设置图片
                 iconView.sd_setImageWithURL(imageURL)
            
            
            }
        
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            
            //准备UI
             prepareUI()
            
        }
        /**
         *  准备UI
         */
        private func prepareUI() {
        //添加子控件
        contentView.addSubview(iconView)
        
        //添加约束
        iconView.ff_Fill(contentView)
        
        }
        //图片
        private lazy var iconView:UIImageView={
        
        let imageView = UIImageView ()
        //设置内容模式
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            imageView.clipsToBounds = true
            return imageView
            
        }()
     
    }
    
  
    


    












