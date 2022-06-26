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
//    func attachApplyWriteRIB()
    func attachPlanRIB()
    func attachApplyRIBfromOtherRIB()
//    func attachWriteApplyOverallRIBfromOtherRIB()
}

protocol TabBarPresentable: Presentable {
    var listener: TabBarPresentableListener? { get set }
    
    func selectBlogButton()
    func selectApplyButton()
    func selectScheduleButton()
    func showTabBar()
    func hideTabBar()
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
        
        tabApplyButton()
    }

    override func willResignActive() {
        super.willResignActive()
        
    }
    
    func tabBlogButton() {
        router?.attachBlogRIB()
        presenter.selectBlogButton()
    }
    
    func tabApplyButton() {
        router?.attachApplyRIB()
        presenter.selectApplyButton()
    }
    
    func tabScheduleButton() {
        router?.attachPlanRIB()
        presenter.selectScheduleButton()
    }
    
    func goBackToApplyRIB() {
        router?.attachApplyRIBfromOtherRIB()
    }
    
    func showTabBar() {
        presenter.showTabBar()
    }
    
    func hideTabBar() {
        presenter.hideTabBar()
    }
    
    
    
//    func goToApplyWriteRIB() {
//        router?.attachApplyWriteRIB()
//    }
//
    // MARK: From Other RIBs
//    func goBackToWriteApplyOverallRIB() {
//        router?.attachWriteApplyOverallRIBfromOtherRIB()
//    }
}
