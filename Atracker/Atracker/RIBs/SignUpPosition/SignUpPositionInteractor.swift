//
//  SignUpPositionInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs
import RxSwift

protocol SignUpPositionRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func attachSignUpSuccessRIB()
}

protocol SignUpPositionPresentable: Presentable {
    var listener: SignUpPositionPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SignUpPositionListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SignUpPositionInteractor: PresentableInteractor<SignUpPositionPresentable>, SignUpPositionInteractable, SignUpPositionPresentableListener {

    weak var router: SignUpPositionRouting?
    weak var listener: SignUpPositionListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SignUpPositionPresentable) {
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
    
    func tapNextButton() {
        router?.attachSignUpSuccessRIB()
    }
}
