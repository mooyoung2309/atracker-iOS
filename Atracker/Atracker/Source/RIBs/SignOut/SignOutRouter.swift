//
//  SignOutRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs

protocol SignOutInteractable: Interactable, SignUpAgreementListener {
    var router: SignOutRouting? { get set }
    var listener: SignOutListener? { get set }
}

protocol SignOutViewControllable: NavigationViewControllable {
    
}

final class SignOutRouter: ViewableRouter<SignOutInteractable, SignOutViewControllable>, SignOutRouting {
    
    private var signUpAgreementBuilder: SignUpAgreementBuildable
    
    private var signUpAgreement: ViewableRouting?
    
    init(interactor: SignOutInteractable, viewController: SignOutViewControllable, signUpAgreementBuilder: SignUpAgreementBuildable) {
        self.signUpAgreementBuilder = signUpAgreementBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSignUpAgreementRIB(idToken: String, sso: SSO) {
        let signUpAgreement = signUpAgreementBuilder.build(withListener: interactor, idToken: idToken, sso: sso)
        
        self.signUpAgreement = signUpAgreement
        attachChild(signUpAgreement)
        viewController.present(signUpAgreement.viewControllable, isTabBarShow: false)
    }
    
    func detachSignUpAgreementRIB() {
        if let signUpAgreement = signUpAgreement {
            detachChild(signUpAgreement)
        }
        viewController.dismiss(nil, isTabBarShow: false)
    }
}
