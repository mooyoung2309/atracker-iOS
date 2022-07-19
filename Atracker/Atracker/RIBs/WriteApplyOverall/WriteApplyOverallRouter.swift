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
    private let origin: WriteApplyOverallViewControllable
    
    private var child: ViewableRouting?
    private var writeApplySchedule: ViewableRouting?
    
    init(interactor: WriteApplyOverallInteractable,
                  viewController: WriteApplyOverallViewControllable,
                  writeApplyScheduleBuilder: WriteApplyScheduleBuildable) {
        self.origin = viewController
        self.writeApplyScheduleBuilder = writeApplyScheduleBuilder
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func attachWriteApplyScheduleRIB(applyCreateRequest: ApplyCreateRequest) {
        let writeApplySchedule = writeApplyScheduleBuilder.build(withListener: interactor, applyCreateRequest: applyCreateRequest)
        self.writeApplySchedule = writeApplySchedule

        detachChildRIB(child)
        attachChild(writeApplySchedule)
        
        viewController.present(writeApplySchedule.viewControllable, isTabBarShow: false)
        
        child = writeApplySchedule
    }
    
    
//    func detachWriteApplyScheduleRIB() {
//        detachChildRIB(child)
//        viewController.dismissView(animation: true)
//    }
    
    func detachThisChildRIB() {
        detachChildRIB(child)
//        viewController.dismissView(animation: true)
        
        child = nil
    }
    
    func testBackButton() {
        detachChild(self)
        viewController.dismiss(nil, isTabBarShow: true)
    }
}
