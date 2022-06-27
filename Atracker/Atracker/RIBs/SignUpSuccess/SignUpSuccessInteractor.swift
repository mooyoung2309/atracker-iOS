//
//  SignUpSuccessInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import RIBs
import RxSwift

protocol SignUpSuccessRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func attachSignInRIB()
}

protocol SignUpSuccessPresentable: Presentable {
    var listener: SignUpSuccessPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SignUpSuccessListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SignUpSuccessInteractor: PresentableInteractor<SignUpSuccessPresentable>, SignUpSuccessInteractable, SignUpSuccessPresentableListener {

    weak var router: SignUpSuccessRouting?
    weak var listener: SignUpSuccessListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SignUpSuccessPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.router?.attachSignInRIB()
        }
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
