//
//  NSString+Extension.swift
//  microblog
//
//  Created by zmx on 15/12/24.
//  Copyright © 2015年 zmx. All rights reserved.
//

import Foundation

extension String {
    
    func getSource() -> (urlStr: String, text: String) {
        let regular = "<a href=\"(.*?)\".*?>(.*?)</a>"
        let expression = try! NSRegularExpression(pattern: regular, options: [])
        let result = expression.matchesInString(self, options: [], range: NSMakeRange(0, self.characters.count))
        var urlStr = ""
        if let range = result.first?.rangeAtIndex(1) {
            urlStr = (self as NSString).substringWithRange(range)
        }
        var text = ""
        if let range = result.first?.rangeAtIndex(2) {
            text = "来自 " + (self as NSString).substringWithRange(range)
        }
        return (urlStr, text)
    }
    
}