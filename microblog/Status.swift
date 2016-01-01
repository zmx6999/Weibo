//
//  Status.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

class Status: NSObject {
    
    var id: Int64 = 0
    
    var user: User?
    
    var created_at: String?
    
    var source: String?
    
    var text: String?
    
    var pic_urls: [[String: String]]? {
        didSet {
            if let OPicUrls = pic_urls {
                picUrls = [NSURL]()
                for item in OPicUrls {
                    var urlStr = item["thumbnail_pic"]
                    urlStr = urlStr?.stringByReplacingOccurrencesOfString("thumbnail", withString: "bmiddle")
                    picUrls?.append(NSURL(string: urlStr ?? "")!)
                }
            }
        }
    }
    
    var retweeted_status: Status?
    
    var picUrls: [NSURL]?
    
    var totalPicUrls: [NSURL]? {
        if let OUrls = retweeted_status?.picUrls where OUrls.count > 0 {
            return OUrls
        }
        return picUrls
    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "user" {
            user = User(dict: value as! [String: AnyObject])
            return
        }
        
        if key == "retweeted_status" {
            retweeted_status = Status(dict: value as! [String: AnyObject])
            return
        }
        
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

}