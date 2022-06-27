//
//  SignUpSuccessRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import RIBs

protocol SignUpSuccessInteractable: Interactable, SignInListener {
    var router: SignUpSuccessRouting? { get set }
    var listener: SignUpSuccessListener? { get set }
}

protocol SignUpSuccessViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SignUpSuccessRouter: ViewableRouter<SignUpSuccessInteractable, SignUpSuccessViewControllable>, SignUpSuccessRouting {
    
    private let signInBuilder: SignInBuildable

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: SignUpSuccessInteractable, viewController: SignUpSuccessViewControllable, signInBuilder: SignInBuildable) {
        self.signInBuilder = signInBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func attachSignInRIB() {
        let signIn = signInBuilder.build(withListener: interactor)
        
        attachChild(signIn)
    }
    
}
