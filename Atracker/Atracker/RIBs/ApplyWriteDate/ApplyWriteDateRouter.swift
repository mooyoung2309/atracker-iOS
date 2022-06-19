//
//  ApplyWriteDateRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs

protocol ApplyWriteDateInteractable: Interactable {
    var router: ApplyWriteDateRouting? { get set }
    var listener: ApplyWriteDateListener? { get set }
}

protocol ApplyWriteDateViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ApplyWriteDateRouter: ViewableRouter<ApplyWriteDateInteractable, ApplyWriteDateViewControllable>, ApplyWriteDateRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ApplyWriteDateInteractable, viewController: ApplyWriteDateViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
