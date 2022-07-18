//
//  SignOutRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs

protocol SignOutInteractable: Interactable, SignUpNicknameListener {
    var router: SignOutRouting? { get set }
    var listener: SignOutListener? { get set }
}

protocol SignOutViewControllable: NavigationViewControllable {
    
}

final class SignOutRouter: ViewableRouter<SignOutInteractable, SignOutViewControllable>, SignOutRouting {
    
    private var signUpNicknameBuilder: SignUpNicknameBuildable
    
    private var signUpNickname: ViewableRouting?
    
    init(interactor: SignOutInteractable, viewController: SignOutViewControllable, signUpNicknameBuilder: SignUpNicknameBuildable) {
        self.signUpNicknameBuilder = signUpNicknameBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func attachSignUpNicknameRIB() {
        let signUpNickname = signUpNicknameBuilder.build(withListener: interactor)
        
        self.signUpNickname = signUpNickname
        
        viewController.present(signUpNickname.viewControllable, isTabBarShow: true)
    }
//
//    func attachWriteApplyOverall() {
//        let writeApplyOverall = writeApplyOverallBuilder.build(withListener: interactor)
//
//        self.writeApplyOverall = writeApplyOverall
//
//        detachChildRIB(child)
//        attachChild(writeApplyOverall)
////        Log("[D] 탭바 안보이게")
//        viewController.presentView(writeApplyOverall, animation: true)
//        child = writeApplyOverall
//    }
}
