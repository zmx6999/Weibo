//
//  HomeWebViewController.swift
//  microblog
//
//  Created by zmx on 15/12/26.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeWebViewController: UIViewController, UIWebViewDelegate {
    
    var urlStr: String?
    
    override func loadView() {
        view = UIWebView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let webView = view as! UIWebView
        webView.delegate = self
        if let url = NSURL(string: urlStr ?? "") {
            webView.loadRequest(NSURLRequest(URL: url))
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        SVProgressHUD.dismiss()
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
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
