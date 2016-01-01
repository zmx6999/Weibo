//
//  Common.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

let KScreen = UIScreen.mainScreen()
let KScreenBounds = KScreen.bounds
let KScreenSize = KScreenBounds.size
let KScreenWidth = KScreenSize.width
let KScreenHeight = KScreenSize.height

let clientId = "2562191751"
let clientSecret = "c2d32fcfdd115702ef11a7e3cc6ff6cb"
let redirectUri = "http://www.baidu.com"

let KPictureMargin: CGFloat = 5
let KStatusCellMargin: CGFloat = 12

let getColor = { (red: Int, green: Int, blue: Int) -> UIColor in
    return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
}

let KSelectRootControllerNotification = "SelectRootControllerNotification"