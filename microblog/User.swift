//
//  User.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var profile_image_url: String? {
        didSet {
            profileImageUrl = NSURL(string: profile_image_url ?? "")
        }
    }
    
    var name: String?
    
    var mbrank: Int = 0 {
        didSet {
            if mbrank > 0 && mbrank < 7 {
                mbrankImage = UIImage(named: "common_icon_membership_level\(mbrank)")
            }
        }
    }
    
    var verified_type: Int = -1 {
        didSet {
            switch verified_type {
            case 0: verifiedTypeImage = UIImage(named: "avatar_vip")
            case 2, 3, 5: verifiedTypeImage =  UIImage(named: "avatar_enterprise_vip")
            case 220: verifiedTypeImage = UIImage(named: "avatar_grassroot")
            default: verifiedTypeImage = nil
            }
        }
    }
    
    var profileImageUrl: NSURL?
    
    var mbrankImage: UIImage?
    
    var verifiedTypeImage: UIImage?
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

}