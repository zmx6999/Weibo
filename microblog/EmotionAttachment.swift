//
//  EmotionAttachment.swift
//  microblog
//
//  Created by zmx on 15/12/25.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

class EmotionAttachment: NSTextAttachment {
    
    var chs: String?

    func getImageText(emotion: Emotion, font: UIFont) -> NSAttributedString? {
        chs = emotion.chs
        image = UIImage(contentsOfFile: emotion.imgPath!)
        bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        let aStrM = NSMutableAttributedString(attributedString: NSAttributedString(attachment: self))
        aStrM.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, 1))
        return aStrM
    }
    
}