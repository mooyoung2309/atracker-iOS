//
//  SignUpNicknameRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs

protocol SignUpNicknameInteractable: Interactable {
    var router: SignUpNicknameRouting? { get set }
    var listener: SignUpNicknameListener? { get set }
}

protocol SignUpNicknameViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SignUpNicknameRouter: ViewableRouter<SignUpNicknameInteractable, SignUpNicknameViewControllable>, SignUpNicknameRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SignUpNicknameInteractable, viewController: SignUpNicknameViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
