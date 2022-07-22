//
//  SignUpNicknameInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs
import RxSwift

protocol SignUpNicknameRouting: ViewableRouting {
    func attachSignUpPositionRIB(idToken: String, sso: SSO, nickname: String)
    func detachSignUpPositionRIB()
}

protocol SignUpNicknamePresentable: Presentable {
    var listener: SignUpNicknamePresentableListener? { get set }
}

protocol SignUpNicknameListener: AnyObject {
    func didTapBackButtonFromSignUpNicknameRIB()
    func didSignUp()
}

final class SignUpNicknameInteractor: PresentableInteractor<SignUpNicknamePresentable>, SignUpNicknameInteractable, SignUpNicknamePresentableListener {

    weak var router: SignUpNicknameRouting?
    weak var listener: SignUpNicknameListener?
    
    private let idToken: String
    private let sso: SSO
    private var nickname: String?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: SignUpNicknamePresentable, idToken: String, sso: SSO) {
        self.idToken = idToken
        self.sso = sso
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func tapBackButton() {
        listener?.didTapBackButtonFromSignUpNicknameRIB()
    }
    
    func tapNextButton() {
        guard let nickname = nickname else { return }
        
        if nickname.isEmpty == false {
            router?.attachSignUpPositionRIB(idToken: idToken, sso: sso, nickname: nickname)
        }
    }
    
    func inputNicknameTextField(text: String) {
        self.nickname = text
    }
    
    func didSignUp() {
        listener?.didSignUp()
    }
}
