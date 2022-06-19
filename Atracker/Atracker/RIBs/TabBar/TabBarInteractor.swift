//
//  TabBarInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs
import RxSwift

protocol TabBarRouting: ViewableRouting {
    func detachChildRIB()
    func attachBlogRIB()
    func attachApplyRIB()
    func attachApplyWriteRIB()
    func attachPlanRIB()
    func attachApplyRIBfromOtherRIB()
}

protocol TabBarPresentable: Presentable {
    var listener: TabBarPresentableListener? { get set }
}

protocol TabBarListener: AnyObject {
    
}

final class TabBarInteractor: PresentableInteractor<TabBarPresentable>, TabBarInteractable, TabBarPresentableListener {
    weak var router: TabBarRouting?
    weak var listener: TabBarListener?

    override init(presenter: TabBarPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
//        router?.attachApplyRIB()
    }

    override func willResignActive() {
        super.willResignActive()
        
    }
    
    func didTabBlog() {
        router?.attachBlogRIB()
    }
    
    func didTabApply() {
        router?.attachApplyRIB()
    }
    
    func didTabPlan() {
        router?.attachPlanRIB()
    }
    
    func goBackToApplyRIB() {
        Log("")
        router?.attachApplyRIBfromOtherRIB()
    }
    
    func goToApplyWriteRIB() {
        router?.attachApplyWriteRIB()
    }
}
