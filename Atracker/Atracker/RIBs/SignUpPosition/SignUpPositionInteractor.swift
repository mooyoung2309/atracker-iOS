//
//  SignUpPositionInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs
import RxSwift

protocol SignUpPositionRouting: ViewableRouting {
    func attachSignUpSuccessRIB()
}

protocol SignUpPositionPresentable: Presentable {
    var listener: SignUpPositionPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func switchCareerTableView()
    func updateCareerLabel(title: String)
}

protocol SignUpPositionListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didSignUp()
}

final class SignUpPositionInteractor: PresentableInteractor<SignUpPositionPresentable>, SignUpPositionInteractable, SignUpPositionPresentableListener {

    weak var router: SignUpPositionRouting?
    weak var listener: SignUpPositionListener?
    
    private let authService: AuthServiceProtocol
    private let nickname: String
    
    private var position: String?
    private var career: String?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: SignUpPositionPresentable, nickname: String, authService: AuthServiceProtocol) {
        self.authService = authService
        self.nickname = nickname
        
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
    
    func inputPositionTextField(text: String) {
        self.position = text
    }
    
    func inputCareerTextField(text: String) {
        self.career = text
    }
    
    func tapCareerTableView(career: String) {
        self.career = career
        presenter.updateCareerLabel(title: career)
        presenter.switchCareerTableView()
    }
    
    func tapNextButton() {
        guard let position = position else { return }
        guard let career = career else { return }
        
        if position.isEmpty || career.isEmpty { return }
        
        authService.testSignUp(email: "TEST1", gender: Gender.male.code, jobPosition: position, nickName: nickname, sso: SSO.apple.code) { [weak self] result in
            switch result {
            case .success(_):
                self?.router?.attachSignUpSuccessRIB()
                Log("[D] 테스트 회원가입 성공")
            case .failure(_):
                Log("[D] 테스트 회원가입 실패")
            }
        }
    }
    
    func tapCareerToggleButton() {
        presenter.switchCareerTableView()
    }
    
    func didSignUp() {
        listener?.didSignUp()
    }
}
