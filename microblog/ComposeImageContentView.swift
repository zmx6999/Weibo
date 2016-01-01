
//
//  ComposeImageContentView.swift
//  microblog
//
//  Created by zmx on 15/12/25.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

class ComposeImageContentView: UIView, UICollectionViewDataSource, ComposeImageCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    var images: [UIImage]?
    
    let col:CGFloat = 4
    
    let max = 9
    
    let identifier = "picture"
    
    override func awakeFromNib() {
        let itemW = (KScreenWidth - KPictureMargin * (col + 1)) / col
        layout.itemSize = CGSize(width: itemW, height: itemW)
        
        collectionView.registerNib(UINib(nibName: "ComposeImageCell", bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let n = images?.count ?? 0
        let d = (n < max ?1: 0)
        return n + d
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! ComposeImageCell
        cell.image = (indexPath.row < images?.count ?images?[indexPath.row] : nil)
        cell.delegate = self
        return cell
    }
    
    func composeImageCellWillAddImage(composeImageCell: ComposeImageCell) {
        let picker = UIImagePickerController()
        picker.delegate = self
        getViewController()?.presentViewController(picker, animated: true, completion: nil)
    }
    
    func composeImageCellWillRemoveImage(composeImageCell: ComposeImageCell) {
        let path = collectionView.indexPathForCell(composeImageCell)
        images?.removeAtIndex((path?.row)!)
        collectionView.reloadData()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        if images == nil {
            images = [UIImage]()
        }
        images?.append(image)
        collectionView.reloadData()
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
}