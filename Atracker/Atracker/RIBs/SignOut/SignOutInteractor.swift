//
//  SignOutInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs
import RxSwift

protocol SignOutRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func attachSignUpNicknameRIB()
}

protocol SignOutPresentable: Presentable {
    var listener: SignOutPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SignOutListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didSignUp()
}

final class SignOutInteractor: PresentableInteractor<SignOutPresentable>, SignOutInteractable, SignOutPresentableListener {

    weak var router: SignOutRouting?
    weak var listener: SignOutListener?
    
    private let authService: AuthService

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: SignOutPresentable, authService: AuthService) {
        self.authService = authService
        
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
    
    func tapGoogleSignUpButton() {
        Log("[D] 구글 회원가입 버튼 클릭")
    }
    
    func tapAppleSignUpButton() {
        Log("[D] 애플 회원가입 버튼 클릭")
    }
    
    func tapTestSignUpButton() {
        Log("[D] 테스트 회원가입 버튼 클릭")
        router?.attachSignUpNicknameRIB()
    }
    
    func didSignUp() {
        listener?.didSignUp()
    }
}
