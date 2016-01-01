//
//  EmotionManager.swift
//  microblog
//
//  Created by zmx on 15/12/25.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

class EmotionManager: NSObject {

    static let sharedManager = EmotionManager()
    
    var packages: [EmotionPackage]?
    
    private override init() {
        super.init()
        
        let dict = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("Emoticons.bundle/emoticons.plist", ofType: nil)!)
        let packs = dict!["packages"] as? [[String: AnyObject]]
        packages = [EmotionPackage]()
        for item in packs! {
            let id = item["id"] as? String
            let packDict = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("Emoticons.bundle/" + (id ?? "") + "/Info.plist", ofType: nil)!)
            let package = EmotionPackage(dict: packDict as! [String: AnyObject])
            packages?.append(package)
        }
    }
    
    private func getEmotion(emoName: String) -> Emotion? {
        for package in packages! {
            let emotions = package.emotions?.filter({ (emotion) -> Bool in
                return emotion.chs == emoName
            })
            if let emotion = emotions?.last {
                return emotion
            }
        }
        return nil
    }
    
    func fullText(str: String?) -> NSAttributedString? {
        guard let _ = str else {
            return nil
        }
        let regular = "\\[.*?\\]"
        let expression = try! NSRegularExpression(pattern: regular, options: [])
        var results = expression.matchesInString(str!, options: [], range: NSMakeRange(0, str!.characters.count))
        let aStrM = NSMutableAttributedString(string: str!)
        aStrM.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(14), range: NSMakeRange(0, aStrM.length))
        aStrM.addAttribute(NSForegroundColorAttributeName, value: UIColor.darkGrayColor(), range: NSMakeRange(0, aStrM.length))
        
        for var i = results.count - 1; i >= 0; i-- {
            let result = results[i]
            let range = result.range
            let emoName = (str! as NSString).substringWithRange(range)
            if let emotion = getEmotion(emoName) {
                aStrM.replaceCharactersInRange(range, withAttributedString: EmotionAttachment().getImageText(emotion, font: UIFont.systemFontOfSize(18))!)
            }
        }
        return aStrM
    }
    
}