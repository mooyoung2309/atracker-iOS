//
//  ApplyEditInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs
import RxSwift

protocol ApplyEditRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ApplyEditPresentable: Presentable {
    var listener: ApplyEditPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol ApplyEditListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func goBackToApplyDetailRIB()
}

final class ApplyEditInteractor: PresentableInteractor<ApplyEditPresentable>, ApplyEditInteractable, ApplyEditPresentableListener {

    weak var router: ApplyEditRouting?
    weak var listener: ApplyEditListener?

    let apply: Apply
    
    init(presenter: ApplyEditPresentable, apply: Apply) {
        self.apply = apply
        
        super.init(presenter: presenter)
        
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapBackButton() {
        Log("")
        listener?.goBackToApplyDetailRIB()
    }
}
