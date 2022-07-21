//
//  SignUpNicknameRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs

protocol SignUpNicknameInteractable: Interactable, SignUpPositionListener {
    var router: SignUpNicknameRouting? { get set }
    var listener: SignUpNicknameListener? { get set }
}

protocol SignUpNicknameViewControllable: NavigationViewControllable {
    
}

final class SignUpNicknameRouter: ViewableRouter<SignUpNicknameInteractable, SignUpNicknameViewControllable>, SignUpNicknameRouting {

    private let signUpPositionBuilder: SignUpPositionBuildable
    
    private var signUpPosition: ViewableRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: SignUpNicknameInteractable, viewController: SignUpNicknameViewControllable, signUpPositionBuilder: SignUpPositionBuildable) {
        self.signUpPositionBuilder = signUpPositionBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func attachSignUpPositionRIB(idToken: String, sso: SSO, nickname: String) {
        let signUpPosition = signUpPositionBuilder.build(withListener: interactor, idToken: idToken, sso: sso, nickname: nickname)
        
        self.signUpPosition = signUpPosition
        attachChild(signUpPosition)
        viewController.present(signUpPosition.viewControllable, isTabBarShow: true)
    }
    
    func detachThisRIB() {
        detachChild(self)
    }
}
