//
//  MainViewController.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

//  raywenderlich.com

//  find . -name "*.swift" | xargs wc -l

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let bar = TabBar(frame: tabBar.frame)
        setValue(bar, forKey: "tabBar")
        addViewControllers()
    }
    
    private func addViewControllers() {
        addViewController(HomeViewController(), imageName: "tabbar_home", title: "首页", tag: 0)
        addViewController(MessageViewController(), imageName: "tabbar_message_center", title: "消息", tag: 1)
        addViewController(DiscoverViewController(), imageName: "tabbar_discover", title: "发现", tag: 2)
        addViewController(ProfileViewController(), imageName: "tabbar_profile", title: "我", tag: 3)
    }

    private func addViewController(vc: UIViewController, imageName: String, title: String, tag: Int) {
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.title = title
        vc.tabBarItem.tag = tag
        addChildViewController(NavigationController(rootViewController: vc))
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        var index = 0
        for subview in tabBar.subviews {
            if subview.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                if index == item.tag {
                    for view in subview.subviews {
                        if view.isKindOfClass(NSClassFromString("UITabBarSwappableImageView")!) {
                            view.transform = CGAffineTransformMakeScale(0.6, 0.6)
                            UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 1, options: [], animations: { () -> Void in
                                view.transform = CGAffineTransformIdentity
                                }, completion: nil)
                        }
                    }
                }
                index++
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}