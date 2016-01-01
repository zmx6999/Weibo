//
//  NetworkTool.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit
import AFNetworking

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
}

class NetworkTool: AFHTTPSessionManager {
    
    let errorDomain = "com.baidu.error"
    
    static let sharedTool: NetworkTool = {
        let tool = NetworkTool(baseURL: NSURL(string: "https://api.weibo.com/"), sessionConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration())
        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tool
    }()
    
    func request(method: HTTPMethod, urlStr: String, params: NSDictionary?, finish: (responseObject: [String: AnyObject]?, error: NSError?) -> Void) {
        if method == HTTPMethod.GET {
            GET(urlStr, parameters: params, progress: nil, success: { (_, responseObject) -> Void in
                guard let obj = responseObject as? [String: AnyObject] else {
                    finish(responseObject: nil, error: NSError(domain: self.errorDomain, code: -1000, userInfo: [NSLocalizedDescriptionKey: "数据格式错误"]))
                    return
                }
                finish(responseObject: obj, error: nil)
                }, failure: { (_, error) -> Void in
                    finish(responseObject: nil, error: error)
            })
        } else {
            POST(urlStr, parameters: params, progress: nil, success: { (_, responseObject) -> Void in
                guard let obj = responseObject as? [String: AnyObject] else {
                    finish(responseObject: nil, error: NSError(domain: self.errorDomain, code: -1000, userInfo: [NSLocalizedDescriptionKey: "数据格式错误"]))
                    return
                }
                finish(responseObject: obj, error: nil)
                }, failure: { (_, error) -> Void in
                    finish(responseObject: nil, error: error)
            })
        }
    }
    
    func uploadWithImage(urlString: String, params: NSDictionary?, imageData: NSData?, finish: (Bool) -> Void) {
        POST(urlString, parameters: params, constructingBodyWithBlock: { (formData) -> Void in
            guard let _ = imageData else {
                return
            }
            formData.appendPartWithFileData(imageData!, name: "pic", fileName: "", mimeType: "image/jpeg")//用jpeg传  否则图片太大超时
            }, progress: { (progress) -> Void in
                print("\(progress.localizedAdditionalDescription)")
            }, success: { (_, responseObject) -> Void in
                guard let _ = responseObject as? [String: AnyObject] else {
                    finish(false)
                    return
                }
                finish(true)
            }) { (_, error) -> Void in
                print("\(error)")
                finish(false)
        }
    }

}