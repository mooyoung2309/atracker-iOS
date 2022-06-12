//
//  ApplyRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs

protocol ApplyInteractable: Interactable, ApplyEditListener, ApplyDetailListener {
    var router: ApplyRouting? { get set }
    var listener: ApplyListener? { get set }
}

protocol ApplyViewControllable: ContainerViewControllable {
    func present(viewController: ViewControllable)
}

final class ApplyRouter: ViewableRouter<ApplyInteractable, ApplyViewControllable>, ApplyRouting {
    
    private let applyEditBuilder: ApplyEditBuildable
    private let applyDetailBuilder: ApplyDetailBuildable
    
    private var current: Routing?
    private var applyEdit: ViewableRouting?
    private var applyDetail: ViewableRouting?
    
    init(interactor: ApplyInteractable,
         viewController: ApplyViewControllable,
         applyEditBuilder: ApplyEditBuildable,
         applyDetailBuilder: ApplyDetailBuildable) {
        
        self.applyEditBuilder = applyEditBuilder
        self.applyDetailBuilder = applyDetailBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func routeToSelf() {
        if let current = current {
            detachChild(current)
        }
    }
    
    func routeToApplyEdit() {
        if let current = current {
            detachChild(current)
        }
        let applyEdit = applyEditBuilder.build(withListener: interactor)
        self.applyEdit = applyEdit
        attachChild(applyEdit)
        viewController.replace(rib: applyEdit)
    }
    
    func routeToApplyDetail(apply: Apply) {
        Log(apply)
        if let current = current {
            detachChild(current)
        }
        let applyDetail = applyDetailBuilder.build(withListener: interactor, apply: apply)
        self.applyDetail = applyDetail
        attachChild(applyDetail)
        viewController.replace(rib: applyDetail)
    }
}
