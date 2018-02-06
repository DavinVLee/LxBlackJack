//
//  KCToolBar.swift
//  JustTest
//
//  Created by Kevin on 2017/6/30.
//  Copyright © 2017年 just play. All rights reserved.
//

import UIKit
import SnapKit

class KCToolBar: UIView {
    
    var homeBtn: UIButton!
    var backBtn: UIButton!
    var nextBtn: UIButton!
    var refreshBtn: UIButton!
    var exitBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        homeBtn = UIButton(type: .custom)
        homeBtn.setImage(UIImage(named: "tab1_nor"), for: .normal)
        addSubview(homeBtn)
        homeBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview().dividedBy(5)
            make.left.top.bottom.equalToSuperview()
        }
        
        backBtn = UIButton(type: .custom)
        backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "tab2_nor"), for: .normal)
        addSubview(backBtn)
        backBtn.snp.makeConstraints {[unowned self] (make) in
            make.left.equalTo(self.homeBtn.snp.right)
            make.top.bottom.width.equalTo(self.homeBtn)
        }
        
        nextBtn = UIButton(type: .custom)
        nextBtn = UIButton(type: .custom)
        nextBtn.setImage(UIImage(named: "tab3_nor"), for: .normal)
        addSubview(nextBtn)
        nextBtn.snp.makeConstraints { [unowned self] (make) in
            make.left.equalTo(self.backBtn.snp.right)
            make.top.bottom.width.equalTo(self.backBtn)
        }
        
        refreshBtn = UIButton(type: .custom)
        refreshBtn = UIButton(type: .custom)
        refreshBtn.setImage(UIImage(named: "tab4_nor"), for: .normal)
        addSubview(refreshBtn)
        refreshBtn.snp.makeConstraints { [unowned self] (make) in
            make.left.equalTo(self.nextBtn.snp.right)
            make.top.bottom.width.equalTo(self.nextBtn)
        }
        
        exitBtn = UIButton(type: .custom)
        exitBtn = UIButton(type: .custom)
        exitBtn.setImage(UIImage(named: "tab5_nor"), for: .normal)
        addSubview(exitBtn)
        exitBtn.snp.makeConstraints { [unowned self] (make) in
            make.left.equalTo(self.refreshBtn.snp.right)
            make.top.bottom.width.equalTo(self.refreshBtn)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




