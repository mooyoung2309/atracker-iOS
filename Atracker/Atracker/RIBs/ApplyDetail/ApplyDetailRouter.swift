//
//  ApplyDetailRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs

protocol ApplyDetailInteractable: Interactable {
    var router: ApplyDetailRouting? { get set }
    var listener: ApplyDetailListener? { get set }
}

protocol ApplyDetailViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ApplyDetailRouter: ViewableRouter<ApplyDetailInteractable, ApplyDetailViewControllable>, ApplyDetailRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ApplyDetailInteractable, viewController: ApplyDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
