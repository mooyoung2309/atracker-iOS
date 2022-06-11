//
//  TabBarInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs
import RxSwift

protocol TabBarRouting: ViewableRouting {
    func routeToBlog()
    func routeToApply()
    func routeToPlan()
    func attachApplyRIB()
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
        
    }

    override func willResignActive() {
        super.willResignActive()
        
    }
    
    func didTabBlog() {
        router?.routeToBlog()
    }
    
    func didTabApply() {
        router?.routeToApply()
    }
    
    func didTabPlan() {
        router?.routeToPlan()
    }
    
    func routeToApply() {
        router?.attachApplyRIB()
        print("routeToApply")
    }
}
