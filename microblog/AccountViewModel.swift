//
//  AccountViewModel.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit
import SVProgressHUD

class AccountViewModel: NSObject {
    
    static let networkTool = NetworkTool.sharedTool
    
    static func login(code: String, finish: ([String: AnyObject]?) -> Void) {
        let params = NSMutableDictionary()
        params["client_id"] = clientId
        params["client_secret"] = clientSecret
        params["grant_type"] = "authorization_code"
        params["code"] = code
        params["redirect_uri"] = redirectUri
        
        networkTool.request(HTTPMethod.POST, urlStr: "oauth2/access_token", params: params) { (responseObject, error) -> Void in
            if error != nil {
                finish(nil)
                return
            }
            finish(responseObject)
        }        
    }
    
    static func loadUserInfo(account: Account, finish: ([String: AnyObject]?) -> Void) {
        let params = NSMutableDictionary()
        params["access_token"] = account.access_token
        params["uid"] = account.uid
        networkTool.request(HTTPMethod.GET, urlStr: "2/users/show.json", params: params) { (responseObject, error) -> Void in
            if error != nil {
                finish(nil)
                return
            }
            finish(responseObject)
        }
    }
    
    static func saveAccount(accout: Account) {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first! + "/account.data"
        NSKeyedArchiver.archiveRootObject(accout, toFile: path)
    }
    
    static func loadAccount() -> Account? {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first! + "/account.data"
        let account = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? Account
        if account != nil && NSDate().compare((account?.expiresTime)!) == NSComparisonResult.OrderedAscending {
            return account
        }
        return nil
    }
    
}