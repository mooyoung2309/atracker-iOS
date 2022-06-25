//
//  SignOutRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs

protocol SignOutInteractable: Interactable {
    var router: SignOutRouting? { get set }
    var listener: SignOutListener? { get set }
}

protocol SignOutViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SignOutRouter: ViewableRouter<SignOutInteractable, SignOutViewControllable>, SignOutRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SignOutInteractable, viewController: SignOutViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
