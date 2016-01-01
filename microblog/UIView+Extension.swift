//
//  UIView+Extension.swift
//  microblog
//
//  Created by zmx on 15/12/26.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

extension UIView {
    
    func getNavigationController() -> UINavigationController? {
        var obj = nextResponder()
        while obj != nil {
            if let nav = obj as? UINavigationController {
                return nav
            }
            obj = obj?.nextResponder()
        }
        return nil
    }
    
    func getTabBarController() -> UITabBarController? {
        var obj = nextResponder()
        while obj != nil {
            if let tab = obj as? UITabBarController {
                return tab
            }
            obj = obj?.nextResponder()
        }
        return nil
    }
    
    func getViewController() -> UIViewController? {
        var obj = nextResponder()
        while obj != nil {
            if let vc = obj as? UIViewController {
                return vc
            }
            obj = obj?.nextResponder()
        }
        return nil
    }
    
}