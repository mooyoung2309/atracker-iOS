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
    func attachBlogRIB()
    func attachApplyRIB()
    func attachMyPageRIB()
    func attachScheduleRIB()
    func detachApplyRIB()
    func detachMyPageRIB()
}

protocol TabBarPresentable: Presentable {
    var listener: TabBarPresentableListener? { get set }
    var action: TabBarPresentableAction? { get }
    var handler: TabBarPresentableHandler? { get set }
}

protocol TabBarListener: AnyObject {
    func didSignOut()
    func detachSignInRIB()
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
            router?.attachMyPageRIB()
//        case 3:
//            router?.attachScheduleRIB()
        default:
            return
        }
    }
    
    // MARK: From Other RIBs
    
    func didSignOut() {
        router?.detachMyPageRIB()
//        router?.attachBlogRIB()
        listener?.didSignOut()
    }
    
    func detachSignInRIB() {
        listener?.detachSignInRIB()
    }
}

extension TabBarInteractor: TabBarPresentableHandler {
    var selectedIndex: Observable<Int> {
        return selectedIndexRelay.asObservable()
    }
}
