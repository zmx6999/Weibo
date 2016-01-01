//
//  EmotionKeyboardCell.swift
//  microblog
//
//  Created by zmx on 15/12/26.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

class EmotionKeyboardCell: UICollectionViewCell {
    
    @IBOutlet weak var button: UIButton!
    
    var emotion: Emotion? {
        didSet {
            button.setImage(UIImage(contentsOfFile: emotion?.imgPath ?? ""), forState: UIControlState.Normal)
            button.setTitle(emotion?.emojiStr ?? "", forState: UIControlState.Normal)
            if emotion?.isDelete == true {
                button.setImage(UIImage(named: "compose_emotion_delete"), forState: UIControlState.Normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
