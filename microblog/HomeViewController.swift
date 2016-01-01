//
//  HomeViewController.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

//蓝色文件夹换肤的时候用

import UIKit
import MJRefresh
import SVProgressHUD

class HomeViewController: BaseViewController {
    
    weak var header: MJRefreshGifHeader!
    
    weak var footer: MJRefreshBackGifFooter!
    
    weak var tipLabel: TipLabel!
    
    var statuses = [Status]()
    
    let identifier = "status"
    
    func refresh(rh: MJRefreshComponent) {
        loadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if isLogin == false {
            beforeLoginView?.setInfo(nil, title: nil)
            return
        }
        
        setupTableView()
        setupRefreshView()
        addTipLabel()
    }
    
    private func setupTableView() {
        tableView.registerClass(StatusCell.self, forCellReuseIdentifier: identifier)
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.backgroundColor = getColor(240, 240, 240)
    }
    
    private func setupRefreshView() {
        let rh = MJRefreshGifHeader(refreshingTarget: self, refreshingAction: "refresh:")
        header =  rh
        tableView.mj_header = header
        header.beginRefreshing()
        
        let rf = MJRefreshBackGifFooter(refreshingTarget: self, refreshingAction: "refresh:")
        footer = rf
        tableView.mj_footer = footer
    }
    
    private func addTipLabel() {
        let tl = NSBundle.mainBundle().loadNibNamed("TipLabel", owner: nil, options: nil).first as! TipLabel
        tipLabel = tl
        navigationController?.navigationBar.insertSubview(tipLabel, atIndex: 0)
        tipLabel.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: 44)
    }
    
    private func loadData() {
        var since_id:Int64 = 0
        var max_id:Int64 = 0
        if footer.isRefreshing() {
            max_id = (statuses.last?.id)! - 1
        } else if statuses.count > 0 {
            since_id = (statuses.first?.id)!
        }
        
        HomeViewModel.loadData(since_id, max_id: max_id) { (list) -> Void in
            self.header.endRefreshing()
            self.footer.endRefreshing()
            
            guard let _ = list else {
                SVProgressHUD.showErrorWithStatus("网络正在睡觉")
                return
            }
            
            if max_id > 0 {
                self.statuses = self.statuses + list!
            } else if since_id > 0 {
                self.statuses = list! + self.statuses
                self.showTipLabel(list!)
            } else {
                self.statuses = list!
            }
            
            self.tableView.reloadData()
        }
    }
    
    private func showTipLabel(list: [Status]) {
        tipLabel.count = list.count
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.tipLabel.transform = CGAffineTransformMakeTranslation(0, 44)
            }) { (_) -> Void in
                UIView.animateWithDuration(0.5, delay: 1, options: [], animations: { () -> Void in
                    self.tipLabel.transform = CGAffineTransformIdentity
                    }, completion: nil)
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! StatusCell
        cell.status = statuses[indexPath.row]
        return cell
    }

    
}