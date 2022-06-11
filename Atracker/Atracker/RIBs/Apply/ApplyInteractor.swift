//
//  ApplyInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs
import RxSwift

protocol ApplyRouting: ViewableRouting {
    func routeToSelf()
    func routeToApplyEdit()
    func routeToApplyDetail(apply: Apply)
}

protocol ApplyPresentable: Presentable {
    var listener: ApplyPresentableListener? { get set }
    func showApplyList(_ applyList: [Apply])
}

protocol ApplyListener: AnyObject {
    func routeToApply()
}

final class ApplyInteractor: PresentableInteractor<ApplyPresentable>, ApplyInteractable, ApplyPresentableListener {

    weak var router: ApplyRouting?
    weak var listener: ApplyListener?
    
    private let service: ApplyServiceProtocol

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: ApplyPresentable, service: ApplyServiceProtocol) {
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
    
    func didTabApplyEdit() {
        router?.routeToApplyEdit()
    }
    
    func didTabCell(apply: Apply) {
        router?.routeToApplyDetail(apply: apply)
    }
    
    func back() {
        router?.routeToSelf()
        listener?.routeToApply()
    }
    
    func reloadApplyList() {
        service.getApplyList { [weak self] (response) in
            guard let this = self else { return }
            this.presenter.showApplyList(response)
        }
    }

}
