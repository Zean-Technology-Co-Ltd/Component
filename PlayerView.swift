//
//  PlayerView.swift
//  NiuNiuRent
//
//  Created by Q Z on 2023/7/7.
//

import UIKit
import WMPlayer
import RxSwift

class PlayerView: NNBaseView {
    let actionObservable = PublishSubject<Void>()
    // MARK: Lifecycle
    deinit {
        print("\(#file)" + "\(#function)")
    }
    
    override func nn_initViews (){
        self.addSubview(navView)
        self.addSubview(playerView)
        navView.addSubviews([
            closeBtn,
            titleLabel
        ])
    }
    
    override func nn_addLayoutSubviews (){
        navView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.navBarHeight)
        }

        closeBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-10)
            make.left.equalTo(15)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(closeBtn)
            make.centerX.equalToSuperview()
        }
        
        playerView.snp.makeConstraints { (make) in
            make.top.equalTo(navView.snp.bottom).offset(0)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-UIScreen.safeAreaBottomPadding)
        }
        
//        playerView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
    }
    
    // MARK: Event Response
    @objc private func didCloseBtnAction(){
        self.pause()
        self.actionObservable.onNext(())
    }
    
    // MARK: Public Method
    public func plyer(title: String, videoUrl: URL){
        self.titleLabel.text = title
        self.playerModel.videoURL = videoUrl
        self.playerView.playerModel = self.playerModel
        self.playerView.play()
    }
    
    public func pause(){
        self.playerView.pause()
    }
    
    // MARK: Private Method
    
    // MARK: Set
    
    // MARK: Get
    private lazy var navView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(R.image.common_close_icon(), for: .normal)
        btn.addTarget(self, action: #selector(didCloseBtnAction), for: .touchUpInside)
        btn.enlargeEdge(top: 10, right: 10, left: 10, bottom: 10)
        return btn
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(text: "", font: .regular(16), textColor: .c1A1A1A)
        return label
    }()
    
    private lazy var playerView: WMPlayer = {
        let view = WMPlayer()
//        view.delegate = self
        view.loopPlay = true
        view.muted = false
        view.enableBackgroundMode = false
        view.backBtnStyle = .none
        view.playerLayerGravity = .resizeAspect
        return view
    }()

    private lazy var playerModel: WMPlayerModel = {
        return WMPlayerModel()
    }()
}


