//
//  SignUpPositionRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs

protocol SignUpPositionInteractable: Interactable {
    var router: SignUpPositionRouting? { get set }
    var listener: SignUpPositionListener? { get set }
}

protocol SignUpPositionViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SignUpPositionRouter: ViewableRouter<SignUpPositionInteractable, SignUpPositionViewControllable>, SignUpPositionRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SignUpPositionInteractable, viewController: SignUpPositionViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
