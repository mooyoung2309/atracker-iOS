//
//  ApplyEditRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs

protocol ApplyEditInteractable: Interactable {
    var router: ApplyEditRouting? { get set }
    var listener: ApplyEditListener? { get set }
}

protocol ApplyEditViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ApplyEditRouter: ViewableRouter<ApplyEditInteractable, ApplyEditViewControllable>, ApplyEditRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ApplyEditInteractable, viewController: ApplyEditViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
