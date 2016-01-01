//
//  HomeViewModel.swift
//  microblog
//
//  Created by zmx on 15/12/27.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewModel: NSObject {
    
    static let networkTool = NetworkTool.sharedTool
    
    static func loadData(since_id: Int64, max_id: Int64, finish: [Status]? -> Void) {
        let params = NSMutableDictionary()
        params["access_token"] = AccountViewModel.loadAccount()?.access_token
        
        if max_id > 0 {
            params["max_id"] = "\(max_id - 1)"
        } else if since_id > 0 {
            params["since_id"] = "\(since_id)"
        }
        
        networkTool.request(HTTPMethod.GET, urlStr: "2/statuses/home_timeline.json", params: params) { (responseObject, error) -> Void in
            if error != nil {
                print("\(error)")
                finish(nil)
                return
            }
            
            let statuses = responseObject!["statuses"] as? [[String: AnyObject]]
            if statuses == nil {
                print("数据格式错误")
                finish(nil)
                return
            }
            
            var list = [Status]()
            for item in statuses! {
                let status = Status(dict: item)
                if status.user?.name != "人民网" && status.user?.name != "人民日报" && status.user?.name != "央视新闻" {
                    list.append(status)
                }
            }
            
            downloadPicture(list, finish: finish)
        }
    }

    private static func downloadPicture(list: [Status], finish: [Status]? -> Void) {
        if list.count == 0 {
            finish(list)
            return
        }
        
        let group = dispatch_group_create()
        
        for status in list {
            if status.totalPicUrls?.count != 1 {
                continue
            }
            
            dispatch_group_enter(group)
            
            SDWebImageManager.sharedManager().downloadImageWithURL(status.totalPicUrls?.first, options: [], progress: nil, completed: { (_, _, _, _, _) -> Void in
                dispatch_group_leave(group)
            })
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            finish(list)
        }
    }

}