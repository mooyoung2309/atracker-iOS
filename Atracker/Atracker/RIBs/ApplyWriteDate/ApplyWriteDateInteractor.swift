//
//  ApplyWriteDateInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs
import RxSwift

protocol ApplyWriteDateRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ApplyWriteDatePresentable: Presentable {
    var listener: ApplyWriteDatePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol ApplyWriteDateListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ApplyWriteDateInteractor: PresentableInteractor<ApplyWriteDatePresentable>, ApplyWriteDateInteractable, ApplyWriteDatePresentableListener {

    weak var router: ApplyWriteDateRouting?
    weak var listener: ApplyWriteDateListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: ApplyWriteDatePresentable) {
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
}
