//
//  EmotionKeyboard.swift
//  microblog
//
//  Created by zmx on 15/12/26.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

class EmotionKeyboard: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    var selectEmotion: ((Emotion) -> Void)?
    
    let manager = EmotionManager.sharedManager
    
    let identifier = "emotion"
    
    @IBAction func clickItem(sender: UIBarButtonItem) {
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: sender.tag), atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
    }
    
    override func awakeFromNib() {
        let itemW = KScreenWidth / 7
        layout.itemSize = CGSize(width: itemW, height: itemW)
        let margin = (bounds.size.height - 36 - itemW * 3) / 4
        layout.sectionInset = UIEdgeInsets(top: margin, left: 0, bottom: margin, right: 0)
        
        collectionView.registerNib(UINib(nibName: "EmotionKeyboardCell", bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return manager.packages?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.packages![section].emotions?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! EmotionKeyboardCell
        cell.emotion = manager.packages![indexPath.section].emotions![indexPath.item]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectEmotion?(manager.packages![indexPath.section].emotions![indexPath.row])
    }
    
}