//
//  ApplyRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs

protocol ApplyInteractable: Interactable, ApplyDetailListener, WriteApplyOverallListener {
    var router: ApplyRouting? { get set }
    var listener: ApplyListener? { get set }
}

protocol ApplyViewControllable: NavigationViewControllable {
    
}

final class ApplyRouter: ViewableRouter<ApplyInteractable, ApplyViewControllable>, ApplyRouting {
    
    private let writeApplyOverallBuilder: WriteApplyOverallBuildable
    private let applyDetailBuilder: ApplyDetailBuildable
    
    private var child: ViewableRouting?
    private var writeApplyOverall: ViewableRouting?
    private var applyDetail: ViewableRouting?
    private var apply: Apply?
    
    init(interactor: ApplyInteractable, viewController: ApplyViewControllable, applyWriteBuilder: WriteApplyOverallBuildable, applyDetailBuilder: ApplyDetailBuildable) {
        self.writeApplyOverallBuilder  = applyWriteBuilder
        self.applyDetailBuilder = applyDetailBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func attachApplyDetailRIB(apply: Apply) {
        self.apply = apply
        let applyDetail = applyDetailBuilder.build(withListener: interactor, apply: apply)
        self.applyDetail = applyDetail
        
//        detachChildRIB(child)
        attachChild(applyDetail)
    
        viewController.present(applyDetail.viewControllable, isTabBarShow: true)
        
        child = applyDetail
    }
    
    func attachWriteApplyOverall() {
        let writeApplyOverall = writeApplyOverallBuilder.build(withListener: interactor)
        
        self.writeApplyOverall = writeApplyOverall
        detachChildRIB(child)
        attachChild(writeApplyOverall)
        viewController.present(writeApplyOverall.viewControllable, isTabBarShow: false)
        child = writeApplyOverall
    }
    
    func detachApplyDetailRIB() {
        if let child = child {
            detachChild(child)
        }
        viewController.dismiss(nil, isTabBarShow: true)
        child = self
    }
    
    func detachThisChildRIB() {
        detachChildRIB(child)
//        viewController.dismissView(animation: true)
        
        child = nil
    }
    
    func detachWriteApplyOverallRIB() {
        guard let writeApplyOverall = writeApplyOverall else { return }

        detachChild(writeApplyOverall)
        
        viewController.dismiss(viewControllable, isTabBarShow: true)
    }
}
