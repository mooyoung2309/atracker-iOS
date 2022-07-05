//
//  EditApplyOverallInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/05.
//

import RIBs
import RxSwift

protocol EditApplyOverallRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol EditApplyOverallPresentable: Presentable {
    var listener: EditApplyOverallPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol EditApplyOverallListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func tapBackButtonFromChildRIB()
}

final class EditApplyOverallInteractor: PresentableInteractor<EditApplyOverallPresentable>, EditApplyOverallInteractable, EditApplyOverallPresentableListener {
    
    weak var router: EditApplyOverallRouting?
    weak var listener: EditApplyOverallListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: EditApplyOverallPresentable) {
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
        listener?.tapBackButtonFromChildRIB()
    }
}
