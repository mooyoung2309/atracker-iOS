//
//  LoggedOutInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs
import RxSwift

protocol LoggedOutRouting: ViewableRouting {
    
}

protocol LoggedOutPresentable: Presentable {
    var listener: LoggedOutPresentableListener? { get set }
}

protocol LoggedOutListener: AnyObject {
    func didLogin(withEmail: String?, _ password: String?)
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener {

    weak var router: LoggedOutRouting?
    weak var listener: LoggedOutListener?
    
    private let authService: AuthServiceProtocol

    init(presenter: LoggedOutPresentable, authService: AuthServiceProtocol) {
        self.authService = authService
        
        super.init(presenter: presenter)
        
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func login(withEmail: String?, _ password: String?) {
        authService.testSignUp(email: "test01@gmail.com", gender: Gender.male.code, jobPosition: "개발자", nickName: "안나포", sso: SSO.google.code) { [weak self] result in
            self?.listener?.didLogin(withEmail: withEmail, password)
        }
    }
}
