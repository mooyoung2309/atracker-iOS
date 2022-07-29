//
//  SignInInteractor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import RIBs
import RxSwift

protocol SignInRouting: Routing {
    func attachTabBarRIB()
    func detachTabBarRIB()
    func cleanupViews()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SignInListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didSignOut()
    func detachSignInRIB()
}

final class SignInInteractor: Interactor, SignInInteractable {

    weak var router: SignInRouting?
    weak var listener: SignInListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init() {}

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        Log("[SIGNOUT] 탭바 RIB attach" )
        router?.attachTabBarRIB()
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    
    func didSignOut() {
        router?.detachTabBarRIB()
        listener?.didSignOut()
    }
    
    func detachSignInRIB() {
        listener?.detachSignInRIB()
    }
}
