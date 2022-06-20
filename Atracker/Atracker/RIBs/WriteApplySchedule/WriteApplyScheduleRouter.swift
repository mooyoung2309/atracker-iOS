//
//  WriteApplyScheduleRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/20.
//

import RIBs

protocol WriteApplyScheduleInteractable: Interactable {
    var router: WriteApplyScheduleRouting? { get set }
    var listener: WriteApplyScheduleListener? { get set }
}

protocol WriteApplyScheduleViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class WriteApplyScheduleRouter: ViewableRouter<WriteApplyScheduleInteractable, WriteApplyScheduleViewControllable>, WriteApplyScheduleRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: WriteApplyScheduleInteractable, viewController: WriteApplyScheduleViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
