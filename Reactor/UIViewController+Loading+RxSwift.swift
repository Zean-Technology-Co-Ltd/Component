//
//  UIViewController+Loading+RxSwift.swift
//  NiuNiuRent
//
//  Created by 张泉 on 2023/4/19.
//

import RxSwift
import RxCocoa

private var loadingIndicatorKey: UInt8 = 0

public extension Reactive where Base: UIViewController {
    
    var isLoading: Binder<Bool> {
        return Binder(self.base) { component, loading in
            if loading {
                component.startLoading()
            } else {
                component.stopLoading()
            }
        }
    }
    
    var isWaiting: Binder<Bool> {
        return Binder(self.base) { component, loading in
            if loading {
                component.startLoading()
            } else {
                component.stopLoading()
            }
        }
    }
}

extension UIViewController {
    
    public final func startLoading() {
        if isViewLoaded {
            HUD.wait()
        }
    }
    /**
     Remove UI blocker.
     */
    public final func stopLoading() {
        HUD.clear()
    }

}
