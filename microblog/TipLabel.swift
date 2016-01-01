//
//  TipLabel.swift
//  microblog
//
//  Created by zmx on 15/12/31.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

class TipLabel: UILabel {

    var count: Int = 0 {
        didSet {
            if count < 1 {
                text = "没有新的微博"
            } else {
                text = "\(count)条新的微博"
            }
        }
    }

}