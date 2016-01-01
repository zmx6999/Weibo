//
//  EmotionPackage.swift
//  microblog
//
//  Created by zmx on 15/12/25.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

class EmotionPackage: NSObject {
    
    var id: String?
    
    var emoticons: [[String: AnyObject]]?
    
    var emotions: [Emotion]?
    
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
        insertEmotions()
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    private func insertEmotions() {
        emotions = [Emotion]()
        var i = 0
        for item in emoticons! {
            let emotion = Emotion(dict: item)
            emotion.id = id
            emotions?.append(emotion)
            i++
            if i == 20 {
                emotions?.append(Emotion(isDelete: true))
                i = 0
            }
        }
        insertEmptyEmotions(i)
    }
    
    private func insertEmptyEmotions(i: Int) {
        if i == 0 {
            return
        }
        for var j = i; j < 20; j++ {
            emotions?.append(Emotion(isEmpty: true))
        }
        emotions?.append(Emotion(isDelete: true))
    }

}