//
//  WriteApplyScheduleRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/20.
//

import RIBs

protocol ApplyWriteScheduleInteractable: Interactable {
    var router: ApplyWriteScheduleRouting? { get set }
    var listener: ApplyWriteScheduleListener? { get set }
}

protocol ApplyWriteScheduleViewControllable: NavigationViewControllable {
    
}

final class ApplyWriteScheduleRouter: ViewableRouter<ApplyWriteScheduleInteractable, ApplyWriteScheduleViewControllable>, ApplyWriteScheduleRouting {
    
    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ApplyWriteScheduleInteractable, viewController: ApplyWriteScheduleViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func detach() {
        detachChild(self)
        viewController.dismiss(nil, isTabBarShow: false)
    }
}
