//
//  ApplyDetailRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs

protocol ApplyDetailInteractable: Interactable, ApplyEditListener {
    var router: ApplyDetailRouting? { get set }
    var listener: ApplyDetailListener? { get set }
}

protocol ApplyDetailViewControllable: NavigationContainerViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ApplyDetailRouter: ViewableRouter<ApplyDetailInteractable, ApplyDetailViewControllable>, ApplyDetailRouting {
    
    
    private let applyEditBuilder: ApplyEditBuildable
    
    private var child: ViewableRouting?
    private var applyEdit: ViewableRouting?
    
    init(interactor: ApplyDetailInteractable,
         viewController: ApplyDetailViewControllable,
         applyEditBuilder: ApplyEditBuilder) {
        
        self.applyEditBuilder = applyEditBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func detachChildRIB() {
        guard let child = child else { return }
        detachChild(child)
    }
    
    func attachApplyEditRIB(apply: Apply) {
        let applyEdit = applyEditBuilder.build(withListener: interactor, apply: apply)
        self.applyEdit = applyEdit
        
        detachChildRIB()
        attachChild(applyEdit)
        
        viewController.pushView(applyEdit, transitionSubType: .fromRight)
        
        child = applyEdit
    }
}
