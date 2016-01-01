//
//  NewFeatureCell.swift
//  microblog
//
//  Created by zmx on 15/12/26.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

class NewFeatureCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var startBtn: UIButton!
    
    @IBAction func start(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(KSelectRootControllerNotification, object: nil)
    }
    
    var index: Int = 0 {
        didSet {
            imageView.image = UIImage(named: "new_feature_\(index + 1)")
            startBtn.hidden = (index < 3)
        }
    }
    
    func startAnimation() {
        startBtn.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: { () -> Void in
            self.startBtn.transform = CGAffineTransformIdentity
            self.layoutIfNeeded()
            }, completion: nil)
    }

}