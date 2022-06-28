//
//  SignUpNicknameInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs
import RxSwift

protocol SignUpNicknameRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func attachSignUpPositionRIB(nickname: String)
}

protocol SignUpNicknamePresentable: Presentable {
    var listener: SignUpNicknamePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SignUpNicknameListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SignUpNicknameInteractor: PresentableInteractor<SignUpNicknamePresentable>, SignUpNicknameInteractable, SignUpNicknamePresentableListener {

    weak var router: SignUpNicknameRouting?
    weak var listener: SignUpNicknameListener?
    
    private var nickname: String?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SignUpNicknamePresentable) {
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
        guard let nickname = nickname else { return }
        
        if nickname.isEmpty == false {
            router?.attachSignUpPositionRIB(nickname: nickname)
        }
    }
    
    func inputNicknameTextField(text: String) {
        self.nickname = text
    }
}
