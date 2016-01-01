//
//  OriginTopView.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit
import SDWebImage
import FFLabel

class OriginTopView: UIView, FFLabelDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var mbtypeImage: UIImageView!
    
    @IBOutlet weak var verifiedImage: UIImageView!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    
    @IBOutlet weak var sourceLabel: UILabel!
 
    @IBOutlet weak var textLabel: FFLabel!
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        let wvc = HomeWebViewController()
        wvc.urlStr = status?.source?.getSource().urlStr
        getNavigationController()?.pushViewController(wvc, animated: true)
    }
    
    var status: Status? {
        didSet {
            profileImageView.sd_setImageWithURL(status?.user?.profileImageUrl)
            nameLabel.text = status?.user?.name
            mbtypeImage.image = status?.user?.mbrankImage
            verifiedImage.image = status?.user?.verifiedTypeImage
            createdAtLabel.text = NSDate.getDate(status?.created_at ?? "")?.getCreatedAtString()
            sourceLabel.text = status?.source?.getSource().text
            textLabel.attributedText = EmotionManager.sharedManager.fullText(status?.text)
        }
    }
    
    static func view() -> OriginTopView {
        return NSBundle.mainBundle().loadNibNamed("OriginTopView", owner: nil, options: nil).first as! OriginTopView
    }
    
    override func awakeFromNib() {
        textLabel.labelDelegate = self
    }
    
    func labelDidSelectedLinkText(label: FFLabel, text: String) {
        if text.hasPrefix("http") {
            let wvc = HomeWebViewController()
            wvc.urlStr = text
            getNavigationController()?.pushViewController(wvc, animated: true)
        }
    }
    
}