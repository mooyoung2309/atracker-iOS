//
//  ApplyRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs

protocol ApplyInteractable: Interactable, ApplyDetailListener, ApplyWriteListener {
    var router: ApplyRouting? { get set }
    var listener: ApplyListener? { get set }
}

protocol ApplyViewControllable: ContainerViewControllable {
    func present(viewController: ViewControllable)
}

final class ApplyRouter: ViewableRouter<ApplyInteractable, ApplyViewControllable>, ApplyRouting {
    
    private let applyWriteBuilder: ApplyWriteBuildable
    private let applyDetailBuilder: ApplyDetailBuildable
    
    private var child: ViewableRouting?
    private var applyWrite: ViewableRouting?
    private var applyDetail: ViewableRouting?
    private var apply: Apply?
    
    init(interactor: ApplyInteractable,
         viewController: ApplyViewControllable,
         applyWriteBuilder: ApplyWriteBuildable,
         applyDetailBuilder: ApplyDetailBuildable) {
        
        self.applyWriteBuilder  = applyWriteBuilder
        self.applyDetailBuilder = applyDetailBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func attachApplyDetailRIB(apply: Apply) {
        self.apply = apply
        let applyDetail = applyDetailBuilder.build(withListener: interactor, apply: apply)
        self.applyDetail = applyDetail
        
        detachChildRIB()
        attachChild(applyDetail)
        viewController.replace(viewController: applyDetail.viewControllable.uiviewController,
                               transitionSubType: .fromRight)
        
        child = applyDetail
    }
    
    func attachApplyWriteRIB() {
        let applyWrite = applyWriteBuilder.build(withListener: interactor)
        self.applyWrite = applyWrite
        
        detachChildRIB()
        attachChild(applyWrite)
        
        viewController.replace(viewController: applyWrite.viewControllable.uiviewController,
                               transitionSubType: .fromRight)

        child = applyWrite
    }
    
    func reAttachApplyDetailRIB() {
        guard let apply = apply else { return }
        let applyDetail = applyDetailBuilder.build(withListener: interactor, apply: apply)
        self.applyDetail = applyDetail
        
        detachChildRIB()
        attachChild(applyDetail)
        viewController.replace(viewController: applyDetail.viewControllable.uiviewController,
                               transitionSubType: .fromLeft)
        
        child = applyDetail
        child = applyDetail
    }
    
    func detachChildRIB() {
        guard let child = child else { return }
        detachChild(child)
    }
}
