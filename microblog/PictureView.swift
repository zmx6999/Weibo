//
//  PictureView.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit
import SDWebImage

class PictureView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, SDPhotoBrowserDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    var picUrls: [NSURL]? {
        didSet {
            snp_updateConstraints { (make) -> Void in
                make.size.equalTo(size!)
            }
            collectionView.reloadData()
        }
    }
    
    var size: CGSize? {
        if picUrls == nil || picUrls?.count == 0 {
            return CGSizeZero
        }
        
        let maxWidth = KScreenWidth - KStatusCellMargin * 2 - KStatusCellMargin * 2
        
        if picUrls?.count == 1 {
            var imageSize = CGSize(width: 180, height: 120)
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(picUrls?.first?.absoluteString)
            if image != nil {
                let imageW = min(image.size.width, maxWidth)
                let imageH = min(image.size.height, 250)
                imageSize = CGSize(width: imageW, height: imageH)
            }
            layout.itemSize = imageSize
            return imageSize
        }
        
        let itemW = (maxWidth - KPictureMargin * 2) / 3.001
        layout.itemSize = CGSize(width: itemW, height: itemW)
        
        if picUrls?.count == 4 {
            let width = itemW * 2 + KPictureMargin
            return CGSize(width: width, height: width)
        }
        
        let col: CGFloat = CGFloat(((picUrls?.count)! - 1) / 3 + 1)
        return CGSize(width: maxWidth, height: itemW * col + KPictureMargin * (col - 1))
    }
    
    let identifier = "picture"
    
    override func awakeFromNib() {
        collectionView.registerNib(UINib(nibName: "PictureCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        collectionView.scrollsToTop = false
    }
    
    static func view() -> PictureView {
        return NSBundle.mainBundle().loadNibNamed("PictureView", owner: nil, options: nil).first as! PictureView
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrls?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! PictureCell
        cell.picUrl = picUrls![indexPath.item]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let browser = SDPhotoBrowser()
        browser.sourceImagesContainerView = collectionView
        browser.imageCount = picUrls?.count ?? 0
        browser.currentImageIndex = indexPath.item
        browser.delegate = self
        browser.show()
    }
    
    func photoBrowser(browser: SDPhotoBrowser!, highQualityImageURLForIndex index: Int) -> NSURL! {
        var urlStr = picUrls![index].absoluteString
        urlStr = urlStr.stringByReplacingOccurrencesOfString("thumbnail", withString: "large")
        return NSURL(string: urlStr)
    }
    
    func photoBrowser(browser: SDPhotoBrowser!, placeholderImageForIndex index: Int) -> UIImage! {
        let cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0)) as! PictureCell
        return cell.imageView.image
    }
    
}