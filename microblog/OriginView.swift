//
//  OriginView.swift
//  microblog
//
//  Created by zmx on 15/12/23.
//  Copyright © 2015年 zmx. All rights reserved.
//

import UIKit
import SnapKit

class OriginView: UIView {

    weak var topView: OriginTopView!
    
    weak var pictureView: PictureView!
    
    var bottomConstraint: Constraint?
    
    var status: Status? {
        didSet {
            topView.status = status
            
            bottomConstraint?.uninstall()
            if let OPicUrls = status?.picUrls where OPicUrls.count > 0 {
                pictureView.picUrls = OPicUrls
                pictureView.hidden = false
                snp_updateConstraints(closure: { (make) -> Void in
                    self.bottomConstraint = make.bottom.equalTo(pictureView.snp_bottom).offset(KStatusCellMargin).constraint
                })
            } else {
                pictureView.hidden = true
                snp_updateConstraints(closure: { (make) -> Void in
                    self.bottomConstraint = make.bottom.equalTo(topView.snp_bottom).constraint
                })
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI() {
        let tv = OriginTopView.view()
        topView = tv
        addSubview(topView)
        
        let pv = PictureView.view()
        pictureView = pv
        addSubview(pictureView)
        
        topView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self)
        }
        
        pictureView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(topView.snp_bottom)
            make.left.equalTo(self.snp_left).offset(KStatusCellMargin)
        }
        
        snp_makeConstraints { (make) -> Void in
            self.bottomConstraint = make.bottom.equalTo(pictureView.snp_bottom).offset(KStatusCellMargin).constraint
        }
    }

}