//
//  HUDReactor.swift
//  NiuNiuRent
//
//  Created by 张泉 on 2023/4/19.
//

import ReactorKit
import RxSwift
import RxCocoa

class HUDReactor: Reactor {
    
    static let shared = HUDReactor()
    
    enum Action {
        case error(String)
        case wait(Bool)
        case warning(String)
        case success(String)
    }
    
    struct State {}
    
    var initialState = State()
    private let disposeBag = DisposeBag()
    
    private init() {
        self.action
            .bind(to: HUD.default.rx.action)
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base: HUD {
    var action: Binder<HUDReactor.Action> {
        return Binder(self.base) { component, action in
            switch action {
            case .error(let msg):
                component.showError(msg)
            case .wait(let ing):
                ing ? component.wait() : component.clear()
            case .warning(let info):
                component.showWarning(info)
            case .success(let msg):
                component.showSuccess(msg)
            }
            
        }
    }
}
