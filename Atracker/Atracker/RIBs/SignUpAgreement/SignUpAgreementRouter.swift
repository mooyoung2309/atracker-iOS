//
//  SignUpAgreementRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/19.
//

import RIBs

protocol SignUpAgreementInteractable: Interactable, SignUpNicknameListener, SignUpAgreementDetailListener {
    var router: SignUpAgreementRouting? { get set }
    var listener: SignUpAgreementListener? { get set }
}

protocol SignUpAgreementViewControllable: NavigationViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SignUpAgreementRouter: ViewableRouter<SignUpAgreementInteractable, SignUpAgreementViewControllable>, SignUpAgreementRouting {
    private let signUpNicknameBuilder: SignUpNicknameBuildable
    private let signUpAgreementDetailBuilder: SignUpAgreementDetailBuildable
    
    private var child: ViewableRouting?
    private var signUpAgreementDetail: ViewableRouting?
    private var signUpNickname: ViewableRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: SignUpAgreementInteractable, viewController: SignUpAgreementViewControllable, signUpAgreementDetailBuilder: SignUpAgreementDetailBuildable, signUpNicknameBuilder: SignUpNicknameBuildable) {
        self.signUpAgreementDetailBuilder = signUpAgreementDetailBuilder
        self.signUpNicknameBuilder = signUpNicknameBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSignUpNicknameRIB(idToken: String, sso: SSO) {
        if let child = child {
            detachChild(child)
        }
        
        let signUpNickname = signUpNicknameBuilder.build(withListener: interactor, idToken: idToken, sso: sso)
        
        self.signUpNickname = signUpNickname
        attachChild(signUpNickname)
        viewController.present(signUpNickname.viewControllable, isTabBarShow: false)
        child = signUpNickname
    }
    
    func attachSignUpAgreementDetailRIB(agreementType: AgreementType) {
        if let child = child {
            detachChild(child)
        }
        
        let signUpAgreementDetail = signUpAgreementDetailBuilder.build(withListener: interactor, agreementType: agreementType)
        self.signUpAgreementDetail = signUpAgreementDetail
        attachChild(signUpAgreementDetail)
        viewController.present(signUpAgreementDetail.viewControllable, isTabBarShow: false)
        child = signUpAgreementDetail
    }
    
    func detachSignUpNicknameRIB() {
        if let child = child {
            detachChild(child)
        }
        viewController.dismiss(nil, isTabBarShow: false)
    }
    
    func detachSignUpAgreementDetailRIB() {
        if let child = child {
            detachChild(child)
        }
        viewController.dismiss(nil, isTabBarShow: false)
    }
}
