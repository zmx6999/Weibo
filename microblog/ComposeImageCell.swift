//
//  ComposeImageCell.swift
//  microblog
//
//  Created by zmx on 15/12/24.
//  Copyright © 2015年 zmx. All rights reserved.
//

//解决循环引用  [weak self]  >= iOS5.0  [unowned self] <iOS5.0相当于retain  __unsafe__unretain

import UIKit

@objc protocol ComposeImageCellDelegate: NSObjectProtocol {
    
    optional func composeImageCellWillAddImage(composeImageCell: ComposeImageCell)
    
    optional func composeImageCellWillRemoveImage(composeImageCell: ComposeImageCell)
    
}

class ComposeImageCell: UICollectionViewCell {
    
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBAction func add(sender: AnyObject) {
        delegate?.composeImageCellWillAddImage?(self)
    }
    
    @IBAction func remove(sender: AnyObject) {
        delegate?.composeImageCellWillRemoveImage?(self)
    }
    
    var delegate: ComposeImageCellDelegate?
    
    var image: UIImage? {
        didSet {
            if image == nil {
                addBtn.setImage(UIImage(named: "compose_pic_add"), forState: UIControlState.Normal)
                addBtn.userInteractionEnabled = true
                closeBtn.hidden = true
            } else {
                addBtn.setImage(image, forState: UIControlState.Normal)
                addBtn.userInteractionEnabled = false
                closeBtn.hidden = false
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        addBtn.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
    }

}
