//
//  ComposeViewController.swift
//  microblog
//
//  Created by zmx on 15/12/24.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit
import SVProgressHUD

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: EmotionTextView!
    
    @IBOutlet weak var tintView: UILabel!
    
    @IBOutlet weak var imageView: ComposeImageView!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    lazy var emotionKeyboard: EmotionKeyboard = {
        var ek = NSBundle.mainBundle().loadNibNamed("EmotionKeyboard", owner: nil, options: nil).first as! EmotionKeyboard
        ek.selectEmotion = { (emotion) -> Void in
            self.textView.insertEmotion(emotion)
        }
        return ek
    }()
    
    @IBAction func pickImage(sender: AnyObject) {
        textView.inputView = nil
        textView.resignFirstResponder()
        imageView.hidden = false
    }
    
    @IBAction func pickEmotion(sender: AnyObject) {
        textView.resignFirstResponder()
        textView.inputView = (textView.inputView == nil ?emotionKeyboard : nil)
        textView.becomeFirstResponder()
    }
    
    @objc private func close() {
        SVProgressHUD.dismiss()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func send() {
        SVProgressHUD.show()
        let networkTool = NetworkTool.sharedTool
        let params = NSMutableDictionary()
        params["access_token"] = AccountViewModel.loadAccount()?.access_token
        params["status"] = textView.fullText()
        if imageView.contentView?.images?.count > 0 {
            networkTool.uploadWithImage("https://upload.api.weibo.com/2/statuses/upload.json", params: params, imageData: UIImageJPEGRepresentation((imageView.contentView?.images?.first)!, 1.0), finish: { (success) -> Void in
                SVProgressHUD.dismiss()
                if success {
                    self.dismissViewControllerAnimated(true, completion: { () -> Void in
                        SVProgressHUD.showSuccessWithStatus("发表成功")
                    })
                } else {
                    SVProgressHUD.showErrorWithStatus("发送失败")
                }
            })
        } else {
            networkTool.request(HTTPMethod.POST, urlStr: "2/statuses/update.json", params: params, finish: { (responseObject, error) -> Void in
                SVProgressHUD.dismiss()
                if error != nil {
                    print("\(error)")
                    return
                }
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    SVProgressHUD.showSuccessWithStatus("发表成功")
                })
            })
        }
    }
    
    func changeKeyboardFrame(notification: NSNotification) {
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let rect = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! Int
        
        bottomConstraint.constant = KScreenHeight - rect.origin.y
        
        UIView.animateWithDuration(duration) { () -> Void in
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: curve)!)
            self.view.layoutIfNeeded()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        if imageView.contentView?.images?.count < 1 {
            textView.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        textView.resignFirstResponder()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    private func setupUI() {
        setupNav()
        setupTextView()
        setupNotification()
    }
    
    private func setupNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发表", style: UIBarButtonItemStyle.Plain, target: self, action: "send")
        navigationItem.rightBarButtonItem?.enabled = false
    }
    
    private func setupTextView() {
        textView.delegate = self
    }
    
    private func setupNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeKeyboardFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    func textViewDidChange(textView: UITextView) {
        navigationItem.rightBarButtonItem?.enabled = (textView.text.characters.count > 0)
        tintView.hidden = (textView.text.characters.count > 0)
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