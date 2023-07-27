//
//  PlaceholderView.swift
//  PlayPa
//
//  Created by wmkj on 2022/7/29.
//

import UIKit
import SnapKit

enum PlaceholderViewType: Int{
    case networkError = 0
    case other
}

@objc
enum PlaceholderImage: Int, RawRepresentable{
    init?(rawValue: String) {
        switch rawValue{
        case "pp_empty_icon":
            self = .common
        case "pp_network_error_icon":
            self = .network_faile
        case "common_order_empty_icon":
            self = .order
        default:
            return nil
        }
    }
    
    case common
    case network_faile
    case order
    
    typealias RawValue = String
    var rawValue: RawValue{
        switch self {
        case .common:
            return "common_placeholder_img"
        case .network_faile:
            return "pp_network_error_icon"
        case .order:
            return "common_order_empty_icon"
        }
    }
}

@objc class PlaceholderView: UIView {

    private var placeHolderIcon: PlaceholderImage = .common
    private var offsetY: Double = 0
    private var placeHolderText: String = ""
    private var refreshBlock: (()->())?
    
    @discardableResult
    convenience init(size: CGSize = .zero, offsetY: Double = 0, placeHolderIcon icon: PlaceholderImage = .common, placeHolderText text: String = "暂无数据~", refreshBlock:(()->())? = nil) {
        self.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        self.placeHolderIcon = icon
        self.placeHolderText = text
        self.offsetY = offsetY
        self.refreshBlock = refreshBlock
        initDatas()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        placeHolderView.snp.makeConstraints { make in
            make.top.equalTo(offsetY)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(dtSize(150))
        }
        
        placeHolderLabel.snp.makeConstraints { make in
            make.top.equalTo(placeHolderView.snp.bottom).offset(dtSize(20))
            make.centerX.width.equalToSuperview()
            make.height.equalTo(dtSize(20))
        }
       
        refreshBtn.snp.makeConstraints { make in
            make.top.equalTo(placeHolderLabel.snp.bottom).offset(dtSize(20))
            make.centerX.equalToSuperview()
            make.width.equalTo(dtSize(110))
            make.height.equalTo(dtSize(40))
        }
    }
    
    func initViews(){
        self.addSubview(placeHolderView)
        self.addSubview(placeHolderLabel)
        self.addSubview(refreshBtn)
        
        self.refreshBtn.isHidden = true
    }
    
    // MARK: private method
    private func dtSize(_ width: CGFloat) -> CGFloat {
        if self.w == 0 {
            return width
        }
        return width * (self.w / UIScreen.screenWidth)
    }
    
    func initDatas(){
        placeHolderView.image = UIImage(named: self.placeHolderIcon.rawValue)
        placeHolderLabel.text = self.placeHolderText
    }
    
    // MARK: event response
    @objc func didClickRefreshBtnAction() {
        self.refreshBlock?()
    }
    
    // MARK: public method
    func updateText(text: String) {
        placeHolderLabel.text = text
    }
    
    func updateIcon(icon: PlaceholderImage) {
        placeHolderView.image = UIImage(named: icon.rawValue)
    }
    
    private var placeholderViewType: PlaceholderViewType = .other
    func updatePlaceholderViewType(type: PlaceholderViewType) {
        if type == .other, self.placeholderViewType == .networkError {
            updateText(text: self.placeHolderText)
            return
        }
        switch type {
        case .networkError:
            self.refreshBtn.isHidden = false
            updateText(text: "通往\(UIDevice.appName)的网络故障了～")
            updateIcon(icon: .network_faile)
        case .other:
            self.refreshBtn.isHidden = true
            updateText(text: self.placeHolderText)
            updateIcon(icon: self.placeHolderIcon)
            
        }
        self.placeholderViewType = type
    }
    
    
    // MARK: private method
    
    // MARK: set
    
    // MARK: get
    private lazy var placeHolderView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private lazy var placeHolderLabel: UILabel = {
        let label = UILabel(font: UIFont.systemFont(ofSize: dtSize(14), weight: .regular), textColor: UIColor(hex: "#9C9C9C"))
        label.textAlignment = .center
        return label
    }()
    
    private lazy var refreshBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "pp_room_list_refresh_bg"), for: .normal)
        btn.addTarget(self, action: #selector(didClickRefreshBtnAction), for: .touchUpInside)
        return btn
    }()

}
