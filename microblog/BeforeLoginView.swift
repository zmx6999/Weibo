//
//  BeforeLoginView.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

class BeforeLoginView: UIView {

    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var houseView: UIImageView!
    
    @IBOutlet weak var titleView: UILabel!
    
    @IBAction func login(sender: AnyObject) {
        getViewController()?.presentViewController(UINavigationController(rootViewController: OAuthViewController()), animated: true, completion: nil)
    }
    
    static func view() -> BeforeLoginView {
        return NSBundle.mainBundle().loadNibNamed("BeforeLoginView", owner: nil, options: nil).first as! BeforeLoginView
    }
    
    func setInfo(iconName: String?, title: String?) {
        if iconName != nil && title != nil {
            bringSubviewToFront(iconView)
            iconView.image = UIImage(named: iconName!)
            titleView.text = title
        } else {
            addAnimation()
        }
    }
    
    private func addAnimation() {
        let anim = CABasicAnimation()
        anim.keyPath = "transform.rotation"
        anim.toValue = M_PI * 2
        anim.duration = 20
        anim.removedOnCompletion = false
        anim.repeatCount = MAXFLOAT
        iconView.layer.addAnimation(anim, forKey: nil)
    }

}