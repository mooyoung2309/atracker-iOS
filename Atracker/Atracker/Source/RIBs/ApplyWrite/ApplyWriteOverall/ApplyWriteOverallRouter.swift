//
//  ApplyWriteRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs

protocol ApplyWriteOverallInteractable: Interactable, WriteApplyScheduleListener {
    var router: ApplyWriteOverallRouting? { get set }
    var listener: ApplyWriteOverallListener? { get set }
}

protocol ApplyWriteOverallViewControllable: NavigationViewControllable {

}

final class ApplyWriteOverallRouter: ViewableRouter<ApplyWriteOverallInteractable, ApplyWriteOverallViewControllable>, ApplyWriteOverallRouting {
    
    private let applyWriteScheduleBuilder: WriteApplyScheduleBuildable
    
    private var writeApplySchedule: ViewableRouting?
    
    init(interactor: ApplyWriteOverallInteractable,
                  viewController: ApplyWriteOverallViewControllable,
                  applyWriteScheduleBuilder: WriteApplyScheduleBuildable) {
        self.applyWriteScheduleBuilder = applyWriteScheduleBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func attachWriteApplyScheduleRIB(applyCreateRequest: ApplyCreateRequest, stages: [Stage]) {
        let writeApplySchedule = applyWriteScheduleBuilder.build(withListener: interactor, applyCreateRequest: applyCreateRequest, stages: stages)
        self.writeApplySchedule = writeApplySchedule

        attachChild(writeApplySchedule)
        viewController.present(writeApplySchedule.viewControllable, isTabBarShow: false)
    }
    
    func detachWriteApplyScheduleRIB() {
        if let writeApplySchedule = writeApplySchedule {
            detachChild(writeApplySchedule)
        }
        viewController.dismiss(nil, isTabBarShow: false)
    }
}
