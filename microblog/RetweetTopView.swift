
//
//  RetweetTopView.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit
import FFLabel

class RetweetTopView: UIView, FFLabelDelegate {

    @IBOutlet weak var textLabel: FFLabel!
    
    var status: Status? {
        didSet {
            textLabel.attributedText = EmotionManager.sharedManager.fullText("@" + (status?.user?.name ?? "") + ": " + (status?.text ?? ""))
        }
    }
    
    static func view() -> RetweetTopView {
        return NSBundle.mainBundle().loadNibNamed("RetweetTopView", owner: nil, options: nil).first as! RetweetTopView
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