//
//  ScheduleRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/20.
//

import RIBs

protocol ScheduleInteractable: Interactable {
    var router: ScheduleRouting? { get set }
    var listener: ScheduleListener? { get set }
}

protocol ScheduleViewControllable: NavigationViewControllable {

}

final class ScheduleRouter: ViewableRouter<ScheduleInteractable, ScheduleViewControllable>, ScheduleRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ScheduleInteractable, viewController: ScheduleViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
