//
//  AppDelegate.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func receiveSelectRootControllerNotification(notification: NSNotification) {
        window?.rootViewController = (notification.object == nil ?MainViewController() : WelcomeViewController())
    }
    
    private func isNewVersion() -> Bool {
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"]?.doubleValue
        let lastVersion = userDefaults.doubleForKey(key)
        if currentVersion > lastVersion {
            userDefaults.setDouble(currentVersion!, forKey: key)
            userDefaults.synchronize()
            return true
        }
        return false
    }
    
    private func selectRootController() {
        if AccountViewModel.loadAccount() == nil {
            window?.rootViewController = MainViewController()
        } else {
            if isNewVersion() {
                window?.rootViewController = NewFeatureViewController(nibName: "NewFeatureViewController", bundle: nil)
            } else {
                window?.rootViewController = WelcomeViewController()
            }
        }
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: KScreenBounds)
        window?.backgroundColor = UIColor.whiteColor()
        
        selectRootController()
        
        window?.makeKeyAndVisible()
        
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UINavigationBar.appearance().translucent = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveSelectRootControllerNotification:", name: KSelectRootControllerNotification, object: nil)
        
        return true
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

