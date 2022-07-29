//
//  NewMyPageRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/29.
//

import RIBs

protocol NewMyPageInteractable: Interactable {
    var router: NewMyPageRouting? { get set }
    var listener: NewMyPageListener? { get set }
}

protocol NewMyPageViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class NewMyPageRouter: ViewableRouter<NewMyPageInteractable, NewMyPageViewControllable>, NewMyPageRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: NewMyPageInteractable, viewController: NewMyPageViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
