//
//  AlertContentVC.swift
//  NiuNiuRent
//
//  Created by Q Z on 2023/5/8.
//

import UIKit
import SwiftEntryKit

class AlertContentVC: UIViewController {
    private var titleText: String?
    private var contentText: String?
    private var contentAttribute: NSMutableAttributedString?
    private var leftTitle: String?
    private var rightTitle: String?
    private var completion: ((Bool)->())?
    // MARK: Lifecycle
    deinit {
        print("\(#file)" + "\(#function)")
    }
    
    convenience init(_ title: String? = nil, content: String, contentAttribute: NSMutableAttributedString? = nil, leftTitle: String? = "取消", rightTitle: String = "确定", completion: ((Bool)->())?) {
        self.init()
        self.titleText = title
        self.contentText = content
        self.contentAttribute = contentAttribute
        self.leftTitle = leftTitle
        self.rightTitle = rightTitle
        self.completion = completion
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: UIScreen.screenWidth, height:UIScreen.screenHeight)
        self.view.backgroundColor = .clear
        nn_initViews()
        nn_addLayoutSubviews()
        nn_initDatas()
    }
    
    private func nn_initViews() {
        
        self.view.addSubviews([
            containterView,
            titleLabel,
            subtitleLabel,
            verLineView,
            horLineView,
            leftBtn,
            rightBtn
        ])
    }
    
    private func nn_initDatas() {
        if let titleText = self.titleText{
            self.titleLabel.text = titleText
            self.titleLabel.isHidden = false
        } else {
            self.titleLabel.isHidden = true
        }
        if let contentAttribute = self.contentAttribute{
            self.subtitleLabel.attributedText = contentAttribute
        } else {
            self.subtitleLabel.text = self.contentText
        }
        
        
        if let leftStr = self.leftTitle {
            verLineView.isHidden = false
            self.leftBtn.isHidden = false
            self.leftBtn.setTitle(leftStr, for: .normal)
        } else {
            self.leftBtn.isHidden = true
            verLineView.isHidden = true
        }
        self.rightBtn.setTitle(self.rightTitle, for: .normal)
    }
    
    private func nn_addLayoutSubviews() {
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-10)
            make.left.equalTo(71.rpx())
            make.right.equalTo(-71.rpx())
            make.height.equalTo(22)
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.equalTo(71.rpx())
            make.right.equalTo(-71.rpx())
        }
        
        horLineView.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(20)
            make.left.equalTo(54.rpx())
            make.right.equalTo(-54.rpx())
            make.height.equalTo(1)
        }
        
        let btn_w = UIScreen.screenWidth * 0.5 - 54.rpx()
        leftBtn.snp.makeConstraints { (make) in
            make.top.equalTo(horLineView.snp.bottom).offset(0)
            make.left.equalTo(54.rpx())
            make.width.equalTo(btn_w)
            make.height.equalTo(48)
        }
        
        if let _ = self.leftTitle{
            rightBtn.snp.makeConstraints { (make) in
                make.top.equalTo(horLineView.snp.bottom).offset(0)
                make.right.equalTo(-54.rpx())
                make.width.equalTo(btn_w)
                make.height.equalTo(48)
            }
            
            verLineView.snp.makeConstraints { (make) in
                make.top.equalTo(horLineView.snp.bottom).offset(0)
                make.centerX.equalToSuperview()
                make.width.equalTo(1)
                make.height.equalTo(48)
            }
        } else {
            rightBtn.snp.makeConstraints { (make) in
                make.top.equalTo(horLineView.snp.bottom).offset(0)
                make.left.equalTo(54.rpx())
                make.right.equalTo(-54.rpx())
                make.height.equalTo(48)
            }
        }
        
        containterView.snp.makeConstraints { (make) in
            if let _ = self.titleText {
                make.top.equalTo(titleLabel.snp.top).offset(-24)
            } else {
                make.top.equalTo(subtitleLabel.snp.top).offset(-24)
            }
            make.left.width.equalTo(horLineView)
            make.bottom.equalTo(rightBtn)
        }
    }
    
    // MARK: Public Method
    
    // MARK: Private Method
    
    // MARK: Request Network
    
    // MARK: Event Response
    @objc private func didClickLeftBtnAction(){
        SwiftEntryKit.dismiss() { [weak self] in
            self?.completion?(false)
        }
    }
    @objc private func didClickRightBtnAction(){
        SwiftEntryKit.dismiss() { [weak self] in
            self?.completion?(true)
        }
    }
    // MARK: Set
    
    // MARK: Get
    private lazy var containterView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.cornerRadius = 10
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(font: .medium(16), textColor: .c1A1A1A)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel(font: .regular(14), textColor: UIColor(hex: "#262626").alpha(0.3))
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var verLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .separatorColor
        return view
    }()
    
    private lazy var horLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .separatorColor
        return view
    }()
    
    private lazy var leftBtn: UIButton = {
        let btn = UIButton(title: "-", textColor: .c1A1A1A, font: .regular(14), target: self, action: #selector(didClickLeftBtnAction))
        return btn
    }()
    
    private lazy var rightBtn: UIButton = {
        let btn = UIButton(title: "-", textColor: .themeColor, font: .medium(14), target: self, action: #selector(didClickRightBtnAction))
        return btn
    }()
}
