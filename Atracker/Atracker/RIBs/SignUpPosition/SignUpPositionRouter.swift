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

protocol SignUpPositionViewControllable: NavigationContainerViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
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
    
    func attachSignUpSuccessRIB() {
        let signUpSuccess = signUpSuccessBuilder.build(withListener: interactor)
        
        self.signUpSuccess = signUpSuccess
        attachChild(signUpSuccess)
        viewController.presentView(signUpSuccess, animation: true)
    }
}
