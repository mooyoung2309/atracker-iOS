//
//  ApplyRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs

protocol ApplyInteractable: Interactable {
    var router: ApplyRouting? { get set }
    var listener: ApplyListener? { get set }
}

protocol ApplyViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ApplyRouter: ViewableRouter<ApplyInteractable, ApplyViewControllable>, ApplyRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ApplyInteractable, viewController: ApplyViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
