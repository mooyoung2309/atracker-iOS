//
//  WriteApplyScheduleInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/20.
//

import RIBs
import RxSwift

protocol WriteApplyScheduleRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func attachScheduleRIB()
}

protocol WriteApplySchedulePresentable: Presentable {
    var listener: WriteApplySchedulePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol WriteApplyScheduleListener: AnyObject {
    func goBackToWriteApplyOverallRIB()
}

final class WriteApplyScheduleInteractor: PresentableInteractor<WriteApplySchedulePresentable>, WriteApplyScheduleInteractable, WriteApplySchedulePresentableListener {

    weak var router: WriteApplyScheduleRouting?
    weak var listener: WriteApplyScheduleListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: WriteApplySchedulePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func tapBackButton() {
        listener?.goBackToWriteApplyOverallRIB()
    }
    
    func didLoad() {
        router?.attachScheduleRIB()
    }
}
