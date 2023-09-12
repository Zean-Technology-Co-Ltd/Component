//
//  HUD.swift
//  NiuNiuRent
//
//  Created by 张泉 on 2023/4/19.
//

import RxSwift
import RxCocoa
import SVProgressHUD

public final class HUD: NSObject {
    
    static let `default`: HUD = {
        return HUD()
    }()
    
    static let autoDismissTime: TimeInterval = 1.5
    
    public func showError(_ message: String?, clearTime: TimeInterval = 1.5) {
        if let message = message {
            HUD.showError(message, clearTime: clearTime)
        }
    }
    
    public func showSuccess(_ message: String?, clearTime: TimeInterval = 1.5) {
        if let message = message {
            HUD.showSuccess(message)
        }
    }
    
    public func showWarning(_ message: String?, clearTime: TimeInterval = 1.5) {
        if let message = message {
            HUD.showInfo(message)
        }
    }
    
    public func wait() {
        HUD.wait()
    }
    
    public func clear() {
        HUD.clear()
    }
    
    static func defaultDeploy() {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setMinimumSize(.zero)
        SVProgressHUD.setCornerRadius(20.0)
        SVProgressHUD.setFont(.systemFont(ofSize: 16))
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor.black)
        SVProgressHUD.setSuccessImage(R.image.hud_success()!)
        SVProgressHUD.setErrorImage(R.image.hud_error()!)
        SVProgressHUD.setInfoImage(R.image.hud_warning()!)
        SVProgressHUD.setFadeInAnimationDuration(0.15)
        SVProgressHUD.setFadeOutAnimationDuration(0.15)
//        SVProgressHUD.setMaxSupportedWindowLevel(UIWindow.Level.alert)
        SVProgressHUD.setShouldTintImages(false)
    }
    
    static func showSuccess(_ message: String, clearTime: TimeInterval = autoDismissTime, completion: SVProgressHUDDismissCompletion? = nil) {
        
        if #available(iOS 10.0, *) {
            let taptic = UIImpactFeedbackGenerator(style: .heavy)
            taptic.prepare()
            taptic.impactOccurred()
        }
        
        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 0, vertical: -(UIScreen.screenHeight * 0.5 * 0.6)))
        SVProgressHUD.showSuccess(withStatus: message)
        SVProgressHUD.dismiss(withDelay: clearTime, completion: completion)
    }
    
    static func showError(_ message: String, clearTime: TimeInterval = autoDismissTime, completion: SVProgressHUDDismissCompletion? = nil) {
        
        if #available(iOS 10.0, *) {
            let taptic = UIImpactFeedbackGenerator(style: .heavy)
            taptic.prepare()
            taptic.impactOccurred()
        }
        
        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 0, vertical: -(UIScreen.screenHeight * 0.5 * 0.6)))
        SVProgressHUD.showError(withStatus: message)
        SVProgressHUD.dismiss(withDelay: clearTime, completion: completion)
    }
    
    static func showInfo(_ message: String, clearTime: TimeInterval = autoDismissTime, completion: SVProgressHUDDismissCompletion? = nil) {
        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 0, vertical: -(UIScreen.screenHeight * 0.5 * 0.6)))
        SVProgressHUD.showInfo(withStatus: message)
        SVProgressHUD.dismiss(withDelay: clearTime, completion: completion)
    }
    
    private static func updateMiniSize(_ update: Bool = true) {
        if update {
            SVProgressHUD.setMinimumSize(CGSize(width: 150, height: 100))
            SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 0, vertical: 0))
        } else {
            SVProgressHUD.setMinimumSize(.zero)
            SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 0, vertical: 0))
        }
    }
    
    static func wait() {
        HUD.updateMiniSize(false)
        SVProgressHUD.show(withStatus: "加载中...")
    }
    
    static func wait(info: String, isEnabled: Bool = false) {
        HUD.updateMiniSize(false)
        SVProgressHUD.show(withStatus: info)
        if isEnabled == true {
            SVProgressHUD.setDefaultMaskType(.none)
        } else {
            SVProgressHUD.setDefaultMaskType(.clear)
        }
    }
    
    static func wait(progress: Float, status: String) {
        HUD.updateMiniSize(false)
        SVProgressHUD.showProgress(progress, status: status)
    }
    
    static func clear() {
        SVProgressHUD.dismiss()
    }
    
}

public extension Reactive where Base: HUD {
    
    var showError: Binder<String?> {
        return Binder(self.base) { component, error in
            component.showError(error)
        }
    }
    
    var showSuccess: Binder<String?> {
        return Binder(self.base) { component, success in
            component.showSuccess(success)
        }
    }
    
    var showWait: Binder<Bool> {
        return Binder(self.base) { component, waiting in
            if waiting {
                component.wait()
            } else {
                component.clear()
            }
        }
    }
    
    var showWarning: Binder<String?> {
        return Binder(self.base) { component, success in
            component.showWarning(success)
        }
    }
}
