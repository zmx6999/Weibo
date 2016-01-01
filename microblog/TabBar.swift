//
//  TabBar.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

class TabBar: UITabBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addComposeButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addComposeButton() {
        let composeBtn = UIButton(imageName: "tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
        addSubview(composeBtn)
        composeBtn.addTarget(self, action: "clickComposeButton", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = KScreenWidth / 5
        let h = bounds.size.height
        var i: CGFloat = 0
        for view in subviews {
            if view.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                view.frame = CGRect(x: w * i, y: 0, width: w, height: h)
                i += (i == 1 ?2: 1)
            } else if view.isKindOfClass(UIButton.classForCoder()) {
                view.center = CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
                view.sizeToFit()
            }
        }
    }
    
    @objc private func clickComposeButton() {
        getTabBarController()?.presentViewController(UINavigationController(rootViewController: ComposeViewController()), animated: true, completion: nil)
    }

}