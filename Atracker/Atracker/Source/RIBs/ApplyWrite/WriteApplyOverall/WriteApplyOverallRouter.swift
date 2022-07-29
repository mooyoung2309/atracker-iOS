//
//  ApplyWriteRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs

protocol WriteApplyOverallInteractable: Interactable, WriteApplyScheduleListener {
    var router: WriteApplyOverallRouting? { get set }
    var listener: WriteApplyOverallListener? { get set }
}

protocol WriteApplyOverallViewControllable: NavigationViewControllable {

}

final class WriteApplyOverallRouter: ViewableRouter<WriteApplyOverallInteractable, WriteApplyOverallViewControllable>, WriteApplyOverallRouting {
    
    private let writeApplyScheduleBuilder: WriteApplyScheduleBuildable
    
    private var writeApplySchedule: ViewableRouting?
    
    init(interactor: WriteApplyOverallInteractable,
                  viewController: WriteApplyOverallViewControllable,
                  writeApplyScheduleBuilder: WriteApplyScheduleBuildable) {
        self.writeApplyScheduleBuilder = writeApplyScheduleBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func attachWriteApplyScheduleRIB(applyCreateRequest: ApplyCreateRequest, stages: [Stage]) {
        let writeApplySchedule = writeApplyScheduleBuilder.build(withListener: interactor, applyCreateRequest: applyCreateRequest, stages: stages)
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
