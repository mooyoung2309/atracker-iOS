//
//  MyPageRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/29.
//

import RIBs

protocol MyPageInteractable: Interactable {
    var router: MyPageRouting? { get set }
    var listener: MyPageListener? { get set }
}

protocol MyPageViewControllable: NavigationViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MyPageRouter: ViewableRouter<MyPageInteractable, MyPageViewControllable>, MyPageRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: MyPageInteractable, viewController: MyPageViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
