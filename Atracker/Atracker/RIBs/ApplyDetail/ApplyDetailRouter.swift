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
    
    private var child: ViewableRouting?
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
        
        detachChildRIB(child)
        attachChild(editApplyOverall)
        
        viewController.present(editApplyOverall.viewControllable, isTabBarShow: false)
        
        child = editApplyOverall
    }
    
    func attachEditApplyStageProgressRIB(apply: Apply) {
        let editApplyStageProgress = editApplyStageProgressBuilder.build(withListener: interactor, apply: apply)
        self.editApplyStageProgress = editApplyStageProgress
        
        detachChildRIB(child)
        attachChild(editApplyStageProgress)
        
        viewController.present(editApplyStageProgress.viewControllable, isTabBarShow: false)
        
        child = editApplyStageProgress
    }
    
    func detachEditApplyOverallRIB() {
        if let child = child {
            detachChild(child)
        }
        viewController.dismiss(nil, isTabBarShow: true)
    }
}
