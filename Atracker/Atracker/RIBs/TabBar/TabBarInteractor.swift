//
//  TabBarInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs
import RxSwift
import RxCocoa

protocol TabBarRouting: ViewableRouting {
    func detachChildRIB()
    func attachBlogRIB()
    func attachApplyRIB()
    func attachPlanRIB()
    func detachApplyRIB()
}

protocol TabBarPresentable: Presentable {
    var listener: TabBarPresentableListener? { get set }
    var action: TabBarPresentableAction? { get }
    var handler: TabBarPresentableHandler? { get set }
}

protocol TabBarListener: AnyObject {
    func didSignOut()
}

final class TabBarInteractor: PresentableInteractor<TabBarPresentable>, TabBarInteractable, TabBarPresentableListener {
    
    weak var router: TabBarRouting?
    weak var listener: TabBarListener?

    private let selectedIndexRelay = BehaviorRelay<Int>(value: 1)
    
    override init(presenter: TabBarPresentable) {
        super.init(presenter: presenter)
        
        presenter.listener = self
        presenter.handler = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        setupBind()
    }

    override func willResignActive() {
        super.willResignActive()
        
        presenter.handler = nil
    }
    
    func setupBind() {
        guard let action = presenter.action else { return }
        guard let handler = presenter.handler else { return }
        
        // 액션 바인딩
        action.tapTabBar
            .bind(to: selectedIndexRelay)
            .disposeOnDeactivate(interactor: self)
        
        
        // 핸들러 바인딩
        handler.selectedIndex
            .bind { [weak self] i in
                self?.tabTabBar(index: i)
            }
            .disposeOnDeactivate(interactor: self)
    }
    
    func tabTabBar(index: Int) {
        Log("[D] \(index)")
        switch index {
        case 0:
            router?.attachBlogRIB()
        case 1:
            router?.attachApplyRIB()
        case 2:
            router?.attachPlanRIB()
        default:
            return
        }
    }
    
    // MARK: From Other RIBs
    
    func didSignOut() {
        Log("[SIGNOUT] start")
        
        router?.detachApplyRIB()
        listener?.didSignOut()
        
        Log("[SIGNOUT] end")
    }
}

extension TabBarInteractor: TabBarPresentableHandler {
    var selectedIndex: Observable<Int> {
        return selectedIndexRelay.asObservable()
    }
}
