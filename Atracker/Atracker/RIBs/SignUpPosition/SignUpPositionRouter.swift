//
//  SignUpPositionRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs

protocol SignUpPositionInteractable: Interactable, SignUpSuccessListener {
    var router: SignUpPositionRouting? { get set }
    var listener: SignUpPositionListener? { get set }
}

protocol SignUpPositionViewControllable: NavigationViewControllable {

}

final class SignUpPositionRouter: ViewableRouter<SignUpPositionInteractable, SignUpPositionViewControllable>, SignUpPositionRouting {
    
    private let signUpSuccessBuilder: SignUpSuccessBuildable
    
    private var signUpSuccess: ViewableRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: SignUpPositionInteractable, viewController: SignUpPositionViewControllable, signUpSuccessBuilder: SignUpSuccessBuildable) {
        
        self.signUpSuccessBuilder = signUpSuccessBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func attachSignUpSuccessRIB(nickName: String, jobPosition: String, jobType: String) {
        let signUpSuccess = signUpSuccessBuilder.build(withListener: interactor, nickName: nickName, jobPosition: jobPosition, jobType: jobType)
        
        self.signUpSuccess = signUpSuccess
        attachChild(signUpSuccess)
        viewController.present(signUpSuccess.viewControllable, isTabBarShow: true)
    }
}
