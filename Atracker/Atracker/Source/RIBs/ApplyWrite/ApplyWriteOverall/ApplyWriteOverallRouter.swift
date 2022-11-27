//
//  ApplyWriteRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs

protocol ApplyWriteOverallInteractable: Interactable, ApplyWriteScheduleListener {
    var router: ApplyWriteOverallRouting? { get set }
    var listener: ApplyWriteOverallListener? { get set }
}

protocol ApplyWriteOverallViewControllable: NavigationViewControllable {

}

final class ApplyWriteOverallRouter: ViewableRouter<ApplyWriteOverallInteractable, ApplyWriteOverallViewControllable>, ApplyWriteOverallRouting {
    private let applyWriteScheduleBuilder: ApplyWriteScheduleBuildable
    
    private var writeApplySchedule: ViewableRouting?
    
    init(interactor: ApplyWriteOverallInteractable,
                  viewController: ApplyWriteOverallViewControllable,
                  applyWriteScheduleBuilder: ApplyWriteScheduleBuildable) {
        self.applyWriteScheduleBuilder = applyWriteScheduleBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func attach(company: Company, jobPosition: String, jobType: JobType, stages: [Stage]) {
        let writeApplySchedule = applyWriteScheduleBuilder.build(withListener: interactor, company: company, jobPosition: jobPosition, jobType: jobType, stages: stages)
        
        self.writeApplySchedule = writeApplySchedule

        attachChild(writeApplySchedule)
        viewController.present(writeApplySchedule.viewControllable, isTabBarShow: false)
    }
    
    func detachChild() {
        if let writeApplySchedule = writeApplySchedule {
            detachChild(writeApplySchedule)
        }
        viewController.dismiss(nil, isTabBarShow: false)
    }
}
