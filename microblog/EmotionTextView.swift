//
//  EmotionTextView.swift
//  microblog
//
//  Created by zmx on 15/12/26.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

class EmotionTextView: UITextView {

    func insertEmotion(emotion: Emotion) {
        if emotion.isEmpty {
            return
        }
        
        if emotion.isDelete {
            deleteBackward()
            return
        }
        
        if emotion.code != nil {
            replaceRange(selectedTextRange!, withText: emotion.emojiStr!)
            return
        }
        
        let range = selectedRange
        let aStrM = NSMutableAttributedString(attributedString: attributedText)
        aStrM.replaceCharactersInRange(range, withAttributedString: EmotionAttachment().getImageText(emotion, font: font!)!)
        attributedText = aStrM
        selectedRange = NSMakeRange(range.location + 1, 0)
        delegate?.textViewDidChange?(self)
    }
    
    func fullText() -> String {
        var strM = String()
        attributedText.enumerateAttributesInRange(NSMakeRange(0, attributedText.length), options: []) { (dict, range, _) -> Void in
            if let attachment = dict["NSAttachment"] as? EmotionAttachment {
                strM += attachment.chs ?? ""
            } else {
                strM += (self.text as NSString).substringWithRange(range)
            }
        }
        strM += "\n"//含有emoji并且末位是默认或浪小花表情  防止末位表情不显示
        return strM
    }

}