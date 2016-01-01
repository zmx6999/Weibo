//
//  WelcomeViewController.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {

    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconBottomConstraint: NSLayoutConstraint!
    
    lazy var account = AccountViewModel.loadAccount()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        iconView.layer.cornerRadius = 45
        iconView.layer.masksToBounds = true
        iconView.sd_setImageWithURL(NSURL(string: account?.avatar_large ?? ""), placeholderImage: UIImage(named: "avatar_default_big"))
        
        titleLabel.text = account?.name ?? "" + " 欢迎回来"
        
        iconBottomConstraint.constant = KScreenHeight - 200
        UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.98, initialSpringVelocity: 9.8, options: [], animations: { () -> Void in
            self.view.layoutIfNeeded()
            }) { (_) -> Void in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.titleLabel.alpha = 1;
                    }, completion: { (_) -> Void in
                        NSNotificationCenter.defaultCenter().postNotificationName(KSelectRootControllerNotification, object: nil)
                })
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}