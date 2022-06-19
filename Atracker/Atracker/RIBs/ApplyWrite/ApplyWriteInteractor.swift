//
//  ApplyWriteInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs
import RxSwift

protocol ApplyWriteRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ApplyWritePresentable: Presentable {
    var listener: ApplyWritePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol ApplyWriteListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func goBackToApplyRIB()
}

final class ApplyWriteInteractor: PresentableInteractor<ApplyWritePresentable>, ApplyWriteInteractable, ApplyWritePresentableListener {

    weak var router: ApplyWriteRouting?
    weak var listener: ApplyWriteListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: ApplyWritePresentable) {
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
    
    func tapBackButton() {
        
        listener?.goBackToApplyRIB()
    }
}
