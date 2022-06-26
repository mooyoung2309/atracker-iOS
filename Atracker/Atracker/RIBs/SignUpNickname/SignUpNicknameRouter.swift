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

protocol SignUpNicknameViewControllable: NavigationContainerViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
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
    
    func attachSignUpPositionRIB() {
        let signUpPosition = signUpPositionBuilder.build(withListener: interactor)
        
        self.signUpPosition = signUpPosition
        attachChild(signUpPosition)
        viewController.presentView(signUpPosition, animation: true)
    }
}
