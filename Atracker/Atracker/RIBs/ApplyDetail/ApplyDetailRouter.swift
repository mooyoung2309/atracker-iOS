//
//  ApplyDetailRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs

protocol ApplyDetailInteractable: Interactable, EditApplyOverallListener, EditApplyStageProgressListener {
    var router: ApplyDetailRouting? { get set }
    var listener: ApplyDetailListener? { get set }
}

protocol ApplyDetailViewControllable: NavigationViewControllable {

}

final class ApplyDetailRouter: ViewableRouter<ApplyDetailInteractable, ApplyDetailViewControllable>, ApplyDetailRouting {
    
    private let editApplyOverallBuilder: EditApplyOverallBuildable
    private let editApplyStageProgressBuilder: EditApplyStageProgressBuildable
    
//    private var child: ViewableRouting?
    private var editApplyOverall: ViewableRouting?
    private var editApplyStageProgress: ViewableRouting?
    
    init(interactor: ApplyDetailInteractable,
         viewController: ApplyDetailViewControllable, editApplyOverallBuilder: EditApplyOverallBuildable, editApplyStageProgressBuilder: EditApplyStageProgressBuildable) {
        
        self.editApplyOverallBuilder = editApplyOverallBuilder
        self.editApplyStageProgressBuilder = editApplyStageProgressBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func attachEditApplyOverallRIB(apply: Apply) {
        let editApplyOverall = editApplyOverallBuilder.build(withListener: interactor, apply: apply)
        self.editApplyOverall = editApplyOverall
        
        attachChild(editApplyOverall)
        viewController.present(editApplyOverall.viewControllable, isTabBarShow: false)
    }
    
    func attachEditApplyStageProgressRIB(apply: Apply) {
        let editApplyStageProgress = editApplyStageProgressBuilder.build(withListener: interactor, apply: apply)
        self.editApplyStageProgress = editApplyStageProgress
        
        attachChild(editApplyStageProgress)
        viewController.present(editApplyStageProgress.viewControllable, isTabBarShow: false)
    }
    
    func detachEditApplyOverallRIB() {
        if let editApplyOverall = editApplyOverall {
            detachChild(editApplyOverall)
        }
        viewController.dismiss(nil, isTabBarShow: false)
    }
    
    func detachEditApplyStageProgressRIB() {
        if let editApplyStageProgress = editApplyStageProgress {
            detachChild(editApplyStageProgress)
        }
        viewController.dismiss(nil, isTabBarShow: false)
    }
}
