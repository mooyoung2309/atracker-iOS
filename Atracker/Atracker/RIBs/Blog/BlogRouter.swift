//
//  BlogRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs

protocol BlogInteractable: Interactable {
    var router: BlogRouting? { get set }
    var listener: BlogListener? { get set }
}

protocol BlogViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class BlogRouter: ViewableRouter<BlogInteractable, BlogViewControllable>, BlogRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: BlogInteractable, viewController: BlogViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
