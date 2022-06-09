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

    override init(presenter: LoggedOutPresentable) {
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
        listener?.didLogin(withEmail: withEmail, password)
    }
}
