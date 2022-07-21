//
//  SignUpAgreementRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/19.
//

import RIBs

protocol SignUpAgreementInteractable: Interactable, SignUpNicknameListener {
    var router: SignUpAgreementRouting? { get set }
    var listener: SignUpAgreementListener? { get set }
}

protocol SignUpAgreementViewControllable: NavigationViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SignUpAgreementRouter: ViewableRouter<SignUpAgreementInteractable, SignUpAgreementViewControllable>, SignUpAgreementRouting {

    private let signUpNicknameBuilder: SignUpNicknameBuildable
    
    private var signUpNickname: ViewableRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: SignUpAgreementInteractable, viewController: SignUpAgreementViewControllable, signUpNicknameBuilder: SignUpNicknameBuildable) {
        self.signUpNicknameBuilder = signUpNicknameBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSignUpNicknameRIB() {
        let signUpNickname = signUpNicknameBuilder.build(withListener: interactor)
        
        self.signUpNickname = signUpNickname
        attachChild(signUpNickname)
        viewController.present(signUpNickname.viewControllable, isTabBarShow: false)
    }
}
