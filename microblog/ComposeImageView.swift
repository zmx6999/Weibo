//
//  ComposeImageView.swift
//  microblog
//
//  Created by zmx on 15/12/25.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

class ComposeImageView: UIView {

    weak var contentView: ComposeImageContentView?
    
    override func awakeFromNib() {
        let cv = NSBundle.mainBundle().loadNibNamed("ComposeImageContentView", owner: nil, options: nil).first as! ComposeImageContentView
        contentView = cv
        addSubview(contentView!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView?.frame = bounds
    }

}