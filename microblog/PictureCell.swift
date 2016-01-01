//
//  PictureCell.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit
import SDWebImage

class PictureCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var picUrl: NSURL? {
        didSet {
            imageView.sd_setImageWithURL(picUrl)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.clipsToBounds = true
    }

}