//
//  NNToast.swift
//  NiuNiuRent
//
//  Created by Q Z on 2023/4/25.
//

import RxSwift
import RxCocoa
import Toast_Swift

public final class Toast: NSObject {
    
    static let `default`: Toast = {
        return Toast()
    }()
    
    static let autoDismissTime: TimeInterval = 2
    
    public func showError(_ message: String?, clearTime: TimeInterval = 2) {
        if let message = message {
            Toast.showError(message, clearTime: clearTime)
        }
    }
    
    public func showSuccess(_ message: String?, clearTime: TimeInterval = 2) {
        if let message = message {
            Toast.showSuccess(message)
        }
    }
    
    public func showWarning(_ message: String?, clearTime: TimeInterval = 2) {
        if let message = message {
            Toast.showInfo(message)
        }
    }
    
    public func wait() {
        Toast.wait()
    }
    
    public func clear() {
        Toast.clear()
    }
    
    static func showToast(_ view: UIView, message: String, image: UIImage?, clearTime: TimeInterval = autoDismissTime, completion: ((_ didTap: Bool)->())? = nil) {
        DispatchQueue.main.async {
            var style = ToastStyle()
            style.messageFont = .regular(15)
            style.messageColor = .white
            style.backgroundColor = .black.alpha(0.6)
            style.messageAlignment = .center
            style.imageSize = CGSize(width: 20, height: 20)
            view.makeToast(message, duration: clearTime, position: .top, image: image, style: style, completion: completion)
        }
    }
    
    static func showToast(_ message: String, image: UIImage?, clearTime: TimeInterval = autoDismissTime, completion: ((_ didTap: Bool)->())? = nil) {
        self.showToast(UIApplication.shared.nn_keyWindow ?? topViewController().view, message: message, image: image, completion: completion)
    }
    
    static func showSuccess(_ message: String, clearTime: TimeInterval = autoDismissTime,  completion: ((_ didTap: Bool)->())? = nil) {
        showToast(message, image: R.image.hud_success(), completion: completion)
    }
    
    static func showError(_ message: String, clearTime: TimeInterval = autoDismissTime,  completion: ((_ didTap: Bool)->())? = nil) {
        showToast(message, image: R.image.hud_error(), completion: completion)
    }
    
    static func showInfo(_ message: String, clearTime: TimeInterval = autoDismissTime,  completion: ((_ didTap: Bool)->())? = nil) {
        showToast(message, image: R.image.hud_warning(), completion: completion)
    }
    
    static func showSuccess(_ view: UIView, message: String, clearTime: TimeInterval = autoDismissTime,  completion: ((_ didTap: Bool)->())? = nil) {
        self.showToast(view, message: message, image: R.image.hud_success(), completion: completion)
    }
    
    static func showError(_ view: UIView, message: String, clearTime: TimeInterval = autoDismissTime,  completion: ((_ didTap: Bool)->())? = nil) {
        self.showToast(view, message: message, image: R.image.hud_error(), completion: completion)
    }
    
    static func showInfo(_ view: UIView, message: String, clearTime: TimeInterval = autoDismissTime,  completion: ((_ didTap: Bool)->())? = nil) {
        self.showToast(view, message: message, image: R.image.hud_warning(), completion: completion)
    }
    
    static func wait() {
        topViewController().view.makeToastActivity(.center)
    }
    
    static func clear() {
        topViewController().view.hideToast()
    }
    
    static func clearAll() {
        topViewController().view.hideAllToasts()
    }
    
}

public extension Reactive where Base: Toast {
    
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
