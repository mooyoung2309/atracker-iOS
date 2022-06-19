//
//  ApplyWriteRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs

protocol ApplyWriteInteractable: Interactable {
    var router: ApplyWriteRouting? { get set }
    var listener: ApplyWriteListener? { get set }
}

protocol ApplyWriteViewControllable: ContainerViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ApplyWriteRouter: ViewableRouter<ApplyWriteInteractable, ApplyWriteViewControllable>, ApplyWriteRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ApplyWriteInteractable, viewController: ApplyWriteViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
