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
    
    init(interactor: ApplyInteractable, viewController: ApplyViewControllable, applyWriteBuilder: WriteApplyOverallBuildable, applyDetailBuilder: ApplyDetailBuildable) {
        self.writeApplyOverallBuilder  = applyWriteBuilder
        self.applyDetailBuilder = applyDetailBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func attachWriteApplyOverallRIB() {
        if let child = child {
            detachChild(child)
        }
        let writeApplyOverall = writeApplyOverallBuilder.build(withListener: interactor)
        
        self.writeApplyOverall = writeApplyOverall
        attachChild(writeApplyOverall)
        viewController.present(writeApplyOverall.viewControllable, isTabBarShow: false)
        
        child = writeApplyOverall
    }
    
    func attachApplyDetailRIB(apply: Apply) {
        if let child = child {
            detachChild(child)
        }
        let applyDetail = applyDetailBuilder.build(withListener: interactor, apply: apply)
        
        self.applyDetail = applyDetail
        attachChild(applyDetail)
        viewController.present(applyDetail.viewControllable, isTabBarShow: false)
        
        child = applyDetail
    }
    
    func detachApplyDetailRIB() {
        if let child = child {
            detachChild(child)
        }
        viewController.dismiss(viewControllable, isTabBarShow: true)
    }
    
    func detachWriteApplyOverallRIB() {
        if let child = child {
            detachChild(child)
        }
        viewController.dismiss(viewControllable, isTabBarShow: true)
    }
}
