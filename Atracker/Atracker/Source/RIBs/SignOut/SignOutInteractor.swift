//
//  SignOutInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs
import RxSwift
import RxCocoa

protocol SignOutRouting: ViewableRouting {
    func attachSignUpAgreementRIB(idToken: String, sso: SSO)
    func detachSignUpAgreementRIB()
}

protocol SignOutPresentable: Presentable {
    var listener: SignOutPresentableListener? { get set }
    var action: SignOutPresentableAction? { get }
    var handler: SignOutPresentableHandler? { get set }
}

protocol SignOutListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didSignUp()
}

final class SignOutInteractor: PresentableInteractor<SignOutPresentable>, SignOutInteractable, SignOutPresentableListener {

    weak var router: SignOutRouting?
    weak var listener: SignOutListener?
    
    private let authService: AuthService
    
    private let idTokenRelay = PublishRelay<String>()
    private let ssoRelay = PublishRelay<SSO>()

    init(presenter: SignOutPresentable, authService: AuthService) {
        self.authService = authService
        super.init(presenter: presenter)
        presenter.listener = self
        presenter.handler = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        setupBind()
    }

    override func willResignActive() {
        super.willResignActive()
        presenter.handler = nil
    }
    
    func setupBind() {
        guard let action = presenter.action else { return }
        guard let handler = presenter.handler else { return }
        
        action.tapGoogleButton
            .bind { [weak self] in
                self?.ssoRelay.accept(SSO.google)
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapAppleButton
            .bind { [weak self] in
                self?.ssoRelay.accept(SSO.apple)
            }
            .disposeOnDeactivate(interactor: self)
        
        action.fetchIdToken
            .bind { [weak self] (sso, idToken) in
                self?.router?.attachSignUpAgreementRIB(idToken: idToken, sso: sso)
            }
            .disposeOnDeactivate(interactor: self)
    }
    
    // 자식 RIB으로 부터
    
    func didSignUp() {
        listener?.didSignUp()
    }
    
    func didTapBackButtonFromSignUpAgreementRIB() {
        router?.detachSignUpAgreementRIB()
    }
}

extension SignOutInteractor: SignOutPresentableHandler {
    var idToken: Observable<String> {
        return idTokenRelay.asObservable()
    }
    
    var sso: Observable<SSO> {
        return ssoRelay.asObservable()
    }
}
