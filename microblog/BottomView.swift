//
//  BottomView.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

class BottomView: UIView {

    static func view() -> BottomView {
        return NSBundle.mainBundle().loadNibNamed("BottomView", owner: nil, options: nil).first as! BottomView
    }

}