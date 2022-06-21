//
//  ApplyRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs

protocol ApplyInteractable: Interactable, ApplyDetailListener {
    var router: ApplyRouting? { get set }
    var listener: ApplyListener? { get set }
}

protocol ApplyViewControllable: NavigationContainerViewControllable {

}

final class ApplyRouter: ViewableRouter<ApplyInteractable, ApplyViewControllable>, ApplyRouting {
    
    private let applyWriteBuilder: WriteApplyOverallBuildable
    private let applyDetailBuilder: ApplyDetailBuildable
    
    private var child: ViewableRouting?
    private var applyWrite: ViewableRouting?
    private var applyDetail: ViewableRouting?
    private var apply: Apply?
    
    init(interactor: ApplyInteractable, viewController: ApplyViewControllable, applyWriteBuilder: WriteApplyOverallBuildable, applyDetailBuilder: ApplyDetailBuildable) {
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
        viewController.presentView(applyDetail, animation: true, transitionSubType: .fromRight)
        
        child = applyDetail
    }
    
//    func attachApplyWriteRIB() {
//        let applyWrite = applyWriteBuilder.build(withListener: interactor)
//        self.applyWrite = applyWrite
//        
//        detachChildRIB()
//        attachChild(applyWrite)
//        
//        viewController.replace(viewController: applyWrite.viewControllable.uiviewController,
//                               transitionSubType: .fromRight)
//
//        child = applyWrite
//    }
    
    func reAttachApplyDetailRIB() {
        guard let apply = apply else { return }
        let applyDetail = applyDetailBuilder.build(withListener: interactor, apply: apply)
        self.applyDetail = applyDetail
        
        detachChildRIB()
        attachChild(applyDetail)
        viewController.presentView(applyDetail, transitionSubType: .fromLeft)
        
        child = applyDetail
    }
    
    func detachChildRIB() {
        guard let child = child else { return }
        detachChild(child)
    }
}
