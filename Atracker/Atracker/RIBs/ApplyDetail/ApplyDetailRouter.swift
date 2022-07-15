//
//  ApplyDetailRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs

protocol ApplyDetailInteractable: Interactable, ApplyEditListener, EditApplyOverallListener, EditApplyStageProgressListener {
    var router: ApplyDetailRouting? { get set }
    var listener: ApplyDetailListener? { get set }
}

protocol ApplyDetailViewControllable: NavigationContainerViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ApplyDetailRouter: ViewableRouter<ApplyDetailInteractable, ApplyDetailViewControllable>, ApplyDetailRouting {
    
    private let applyEditBuilder: ApplyEditBuildable
    private let editApplyOverallBuilder: EditApplyOverallBuildable
    private let editApplyStageProgressBuilder: EditApplyStageProgressBuildable
    
    private var child: ViewableRouting?
    private var applyEdit: ViewableRouting?
    private var editApplyOverall: ViewableRouting?
    private var editApplyStageProgress: ViewableRouting?
    
    init(interactor: ApplyDetailInteractable,
         viewController: ApplyDetailViewControllable,
         applyEditBuilder: ApplyEditBuilder, editApplyOverallBuilder: EditApplyOverallBuildable, editApplyStageProgressBuilder: EditApplyStageProgressBuildable) {
        
        self.applyEditBuilder = applyEditBuilder
        self.editApplyOverallBuilder = editApplyOverallBuilder
        self.editApplyStageProgressBuilder = editApplyStageProgressBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func attachApplyEditRIB(apply: Apply) {
        let applyEdit = applyEditBuilder.build(withListener: interactor, apply: apply)
        self.applyEdit = applyEdit
        
        detachChildRIB(child)
        attachChild(applyEdit)
        
        viewController.presentView(applyEdit, transitionSubType: .fromRight)
        
        child = applyEdit
    }
    
    func attachEditApplyOverallRIB() {
        let editApplyOverall = editApplyOverallBuilder.build(withListener: interactor)
        self.editApplyOverall = editApplyOverall
        
        detachChildRIB(child)
        attachChild(editApplyOverall)
        
        viewController.presentView(editApplyOverall)
        
        child = editApplyOverall
    }
    
    func attachEditApplyStageProgressRIB(apply: Apply) {
        let editApplyStageProgress = editApplyStageProgressBuilder.build(withListener: interactor, apply: apply)
        self.editApplyStageProgress = editApplyStageProgress
        
        detachChildRIB(child)
        attachChild(editApplyStageProgress)
        
        viewController.presentView(editApplyStageProgress)
        
        child = editApplyStageProgress
    }
    
    func detachThisChildRIB() {
        detachChildRIB(child)
        viewController.dismissView(animation: true)
    }
}
