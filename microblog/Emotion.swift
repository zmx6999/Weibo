//
//  Emotion.swift
//  microblog
//
//  Created by zmx on 15/12/25.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

class Emotion: NSObject {

    var id: String?
    
    var chs: String?
    
    var png: String?
    
    var code: String?
    
    var isEmpty = false
    
    var isDelete = false
    
    var imgPath: String? {
        return NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/" + (id ?? "") + "/" + (png ?? "")
    }
    
    var emojiStr: String? {
        let scanner = NSScanner(string: code ?? "")
        var value: UInt32 = 0
        scanner.scanHexInt(&value)
        let c = Character(UnicodeScalar(value))
        return "\(c)"
    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    init(isEmpty: Bool) {
        super.init()
        self.isEmpty = isEmpty
    }
    
    init(isDelete: Bool) {
        super.init()
        self.isDelete = isDelete
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}