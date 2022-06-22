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

protocol WriteApplyOverallViewControllable: NavigationContainerViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
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
    
    func attachWriteApplyScheduleRIB() {
        let writeApplySchedule = writeApplyScheduleBuilder.build(withListener: interactor)
        self.writeApplySchedule = writeApplySchedule

        detachChildRIB(child)
        attachChild(writeApplySchedule)
        viewController.presentView(writeApplySchedule, transitionSubType: .fromRight)

        child = writeApplySchedule
    }
    
    func detachWriteApplyScheduleRIB() {
        detachChildRIB(child)
        viewController.dismissView(animation: true)
    }
}
