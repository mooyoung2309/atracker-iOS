//
//  ApplyInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs
import RxSwift

protocol ApplyRouting: ViewableRouting {
    func attachApplyDetailRIB(apply: ApplyResponse)
    func attachWriteApplyOverall()
    func detachThisChildRIB()
    func reAttachApplyDetailRIB()
}

protocol ApplyPresentable: Presentable {
    var listener: ApplyPresentableListener? { get set }
    func showApplyList(_ applyList: [ApplyResponse])
}

protocol ApplyListener: AnyObject {
//    func goBackToApplyRIB()
//    func goToApplyWriteRIB()
    func showTabBar()
    func hideTabBar()
}

final class ApplyInteractor: PresentableInteractor<ApplyPresentable>, ApplyInteractable, ApplyPresentableListener {

    weak var router: ApplyRouting?
    weak var listener: ApplyListener?
    
    private let service: ApplyServiceProtocolISOLDCODE

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: ApplyPresentable, service: ApplyServiceProtocolISOLDCODE) {
        self.service = service
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        reloadApplyList()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTabCell(apply: ApplyResponse) {
        router?.attachApplyDetailRIB(apply: apply)
    }
    
    func tapPlusButton() {
        listener?.hideTabBar()
        router?.attachWriteApplyOverall()
    }
    
    func reloadApplyList() {
        service.getApplyList { [weak self] (response) in
            guard let this = self else { return }
            this.presenter.showApplyList(response)
        }
    }
    
//    func goBackToApplyRIB() {
//        router?.detachChildRIB()
//        listener?.goBackToApplyRIB()
//    }
//    
//    func goBackToApplyDetailRIB() {
//        router?.reAttachApplyDetailRIB()
//    }
//

    // MARK: From Child RIB
    func tapBackButtonFromChildRIB() {
        router?.detachThisChildRIB()
    }
    
    func showTabBar() {
        listener?.showTabBar()
    }
    
    func hideTabBar() {
        listener?.hideTabBar()
    }
}
