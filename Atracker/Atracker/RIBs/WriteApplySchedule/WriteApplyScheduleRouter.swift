//
//  WriteApplyScheduleRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/20.
//

import RIBs

protocol WriteApplyScheduleInteractable: Interactable, ScheduleListener {
    var router: WriteApplyScheduleRouting? { get set }
    var listener: WriteApplyScheduleListener? { get set }
}

protocol WriteApplyScheduleViewControllable: NavigationContainerViewControllable {
    func presentScheduleView(_ scheduleViewController: ScheduleViewController)
    func dismissScheduleView()
}

final class WriteApplyScheduleRouter: ViewableRouter<WriteApplyScheduleInteractable, WriteApplyScheduleViewControllable>, WriteApplyScheduleRouting {

    private let scheduleBuilder: ScheduleBuildable
    
    private var child: ViewableRouting?
    private var schedule: ViewableRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: WriteApplyScheduleInteractable, viewController: WriteApplyScheduleViewControllable, scheduleBuilder: ScheduleBuildable) {
        self.scheduleBuilder = scheduleBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachScheduleRIB() {
        let schedule = scheduleBuilder.build(withListener: interactor)
        self.schedule = schedule
        
        detachChildRIB(child)
        attachChild(schedule)
        
        guard let scheduleViewController = schedule.viewControllable.uiviewController as? ScheduleViewController else { return }
        
        scheduleViewController.view.layoutIfNeeded()
        viewController.presentScheduleView(scheduleViewController)
        
        child = schedule
    }
}
