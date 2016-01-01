//
//  StatusCell.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit
import SnapKit

class StatusCell: UITableViewCell {
    
    weak var originView: OriginView!
    
    weak var retweetView: RetweetView!
    
    weak var bottomView: BottomView!
    
    var bottomViewTopConstraint: Constraint?
    
    var status: Status? {
        didSet {
            originView.status = status
            
            bottomViewTopConstraint?.uninstall()
            if let retweetStatus = status?.retweeted_status {
                retweetView.status = retweetStatus
                retweetView.hidden = false
                bottomView.snp_updateConstraints(closure: { (make) -> Void in
                    self.bottomViewTopConstraint = make.top.equalTo(retweetView.snp_bottom).offset(KStatusCellMargin).constraint
                })
            } else {
                retweetView.hidden = true
                bottomView.snp_updateConstraints(closure: { (make) -> Void in
                    self.bottomViewTopConstraint = make.top.equalTo(originView.snp_bottom).constraint
                })
            }
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = UITableViewCellSelectionStyle.None
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupUI() {
        let ov = OriginView()
        originView = ov
        contentView.addSubview(originView)
        
        let rv = RetweetView()
        retweetView = rv
        contentView.addSubview(retweetView)
        
        let bv = BottomView.view()
        bottomView = bv
        contentView.addSubview(bottomView)
        
        originView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(contentView)
        }
        
        retweetView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(originView.snp_bottom)
            make.left.equalTo(contentView.snp_left).offset(KStatusCellMargin)
            make.right.equalTo(contentView.snp_right).offset(-KStatusCellMargin)
        }
        
        bottomView.snp_makeConstraints { (make) -> Void in
            self.bottomViewTopConstraint = make.top.equalTo(retweetView.snp_bottom).offset(KStatusCellMargin).constraint
            make.left.right.equalTo(contentView)
            make.height.equalTo(40)
        }
        
        contentView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(bottomView.snp_bottom)
        }
    }

}