//
//  SignOutInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs
import RxSwift

protocol SignOutRouting: ViewableRouting {
    func attachSignUpAgreementRIB()
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
        
        action.tapGoogleButton
            .bind { [weak self] in
                self?.didTapTestButton()
            }
            .disposeOnDeactivate(interactor: self)
        
        action.tapTestButton
            .bind { [weak self] in
                self?.didTapTestButton()
            }
            .disposeOnDeactivate(interactor: self)
    }
    
    private func didTapGoogleButton() {
        
    }
    
    private func didTapTestButton() {
        router?.attachSignUpAgreementRIB()
    }
    
    func signUp(idToken: String) {
        
    }
    
    // 자식 RIB으로 부터
    
    func didSignUp() {
        listener?.didSignUp()
    }
    
    func didBackFromSignUpAgreement() {
        router?.detachSignUpAgreementRIB()
    }
}

extension SignOutInteractor: SignOutPresentableHandler {
    
}
