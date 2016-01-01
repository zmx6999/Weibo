//
//  OAuthViewController.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController, UIWebViewDelegate {
    
    @objc private func close() {
        SVProgressHUD.dismiss()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func fill() {
        let js = "document.getElementById('userId').value='17092875286';document.getElementById('passwd').value='6593147000ddzg'"
        (view as! UIWebView).stringByEvaluatingJavaScriptFromString(js)
    }
    
    override func loadView() {
        view = UIWebView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNav()
        setupUI()
    }
    
    private func setupNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: UIBarButtonItemStyle.Plain, target: self, action: "fill")
    }
    
    private func setupUI() {
        let webView = view as! UIWebView
        webView.delegate = self
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(clientId)&redirect_uri=\(redirectUri)&response_type=code")!))
    }

    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    let networkTool = NetworkTool.sharedTool
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let urlStr = request.URL?.absoluteString
        
        if urlStr?.hasPrefix("https://api.weibo.com/") == true {
            return true
        }
        
        if urlStr?.containsString("code=") == false {
            return false
        }
        
        let code = urlStr?.substringFromIndex((urlStr?.rangeOfString("code=")?.endIndex)!)
        AccountViewModel.login(code!) { (responseObject) -> Void in
            guard let _ = responseObject else {
                SVProgressHUD.showErrorWithStatus("网络正在睡觉")
                return
            }
            let account = Account(dict: responseObject!)
            self.loadUserInfo(account)
        }
        
        return false
    }
    
    private func loadUserInfo(account: Account) {
        AccountViewModel.loadUserInfo(account, finish: { (responseObject) -> Void in
            guard let _ = responseObject else {
                SVProgressHUD.showErrorWithStatus("网络正在睡觉")
                return
            }
            account.avatar_large = responseObject!["avatar_large"] as? String
            account.name = responseObject!["name"] as? String
            AccountViewModel.saveAccount(account)
            
            let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"]?.doubleValue
            userDefaults.setDouble(currentVersion!, forKey: key)
            userDefaults.synchronize()
            
            self.dismissViewControllerAnimated(false, completion: { () -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName(KSelectRootControllerNotification, object: "welcome")
            })
        })
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
