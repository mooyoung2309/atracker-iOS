//
//  SignUpSuccessInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import RIBs
import RxSwift

protocol SignUpSuccessRouting: ViewableRouting {
    
}

protocol SignUpSuccessPresentable: Presentable {
    var listener: SignUpSuccessPresentableListener? { get set }
    func showNickname(nickname: String)
}

protocol SignUpSuccessListener: AnyObject {
    func didSignUp()
}

final class SignUpSuccessInteractor: PresentableInteractor<SignUpSuccessPresentable>, SignUpSuccessInteractable, SignUpSuccessPresentableListener {
    
    weak var router: SignUpSuccessRouting?
    weak var listener: SignUpSuccessListener?

    private let nickName: String
    
    init(presenter: SignUpSuccessPresentable, nickName: String) {
        self.nickName = nickName
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        presenter.showNickname(nickname: nickName)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.listener?.didSignUp()
        }
    }

    override func willResignActive() {
        super.willResignActive()
    }
}
