//
//  NNRefreshGifFooter.swift
//  NiuNiuRent
//
//  Created by 张泉 on 2023/4/19.
//

import MJRefresh
import SnapKit

class NNRefreshGifFooter: MJRefreshBackGifFooter {
    
    override func prepare() {
        super.prepare()
        
        self.stateLabel?.font = .regular(10)
        self.stateLabel?.textColor = UIColor(hex: "#DBDBDB")
        self.setTitle("上拉加载更多", for: .idle)
        self.setTitle("释放加载更多", for: .pulling)
        self.setTitle("加载中", for: .refreshing)
        self.setTitle("我们是有底线的～", for: .noMoreData)
        self.mj_h = 88
        
        self.gifView?.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(35)
        }
        
        self.stateLabel?.snp.makeConstraints { make in
            make.top.equalTo(68)
            make.centerX.equalToSuperview()
        }
    }
}
