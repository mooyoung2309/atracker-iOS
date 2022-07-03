//
//  ApplyDetailInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs
import RxSwift

protocol ApplyDetailRouting: ViewableRouting {
    func detachChildRIB()
    func attachApplyEditRIB(apply: ApplyResponse)
    func detachThisChildRIB()
}

protocol ApplyDetailPresentable: Presentable {
    var listener: ApplyDetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func setNavigaionBarTitle(_ text: String)
}

protocol ApplyDetailListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func tapBackButtonFromChildRIB()
}

final class ApplyDetailInteractor: PresentableInteractor<ApplyDetailPresentable>, ApplyDetailInteractable, ApplyDetailPresentableListener {
    
    weak var router: ApplyDetailRouting?
    weak var listener: ApplyDetailListener?

    let apply: ApplyResponse
    
    init(presenter: ApplyDetailPresentable, apply: ApplyResponse) {
        self.apply = apply
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        presenter.setNavigaionBarTitle(apply.companyName)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func tapBackButton() {
        listener?.tapBackButtonFromChildRIB()
    }
    
    func tapEditButton() {
        router?.attachApplyEditRIB(apply: apply)
    }
    
    func goBackToApplyDetailRIB() {
        router?.detachChildRIB()
//        listener?.goBackToApplyDetailRIB()
    }
    
    func tapBackButtonFromChildRIB() {
        router?.detachThisChildRIB()
    }
}
