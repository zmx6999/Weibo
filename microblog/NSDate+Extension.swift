//
//  NSDate+Extension.swift
//  microblog
//
//  Created by zmx on 15/12/24.
//  Copyright © 2015年 zmx. All rights reserved.
//

import Foundation

extension NSDate {
    
    static func getDate(str: String) -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        formatter.locale = NSLocale(localeIdentifier: "en")
        return formatter.dateFromString(str)
    }
    
    func getCreatedAtString() -> String {
        let calendar = NSCalendar.currentCalendar()
        if calendar.isDateInToday(self) {
            let d = NSDate().timeIntervalSinceDate(self)
            if d < 60 {
                return "刚刚"
            } else if d < 3600 {
                return "\(Int(d / 60))分钟前"
            } else {
                return "\(Int(d / 3600))小时前"
            }
        } else {
            let formatter = NSDateFormatter()
            if calendar.isDateInYesterday(self) {
                formatter.dateFormat = "昨天 HH:mm"
            } else {
                let component = calendar.components(NSCalendarUnit.Year, fromDate: self, toDate: NSDate(), options: [])
                if component.year == 0 {
                    formatter.dateFormat = "MM-dd"
                } else {
                    formatter.dateFormat = "yyyy-MM-dd"
                }
            }
            return formatter.stringFromDate(self)
        }
    }
    
}