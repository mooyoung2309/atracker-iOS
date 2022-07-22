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
    
    private var writeApplyOverall: ViewableRouting?
    private var applyDetail: ViewableRouting?
    
    init(interactor: ApplyInteractable, viewController: ApplyViewControllable, applyWriteBuilder: WriteApplyOverallBuildable, applyDetailBuilder: ApplyDetailBuildable) {
        self.writeApplyOverallBuilder  = applyWriteBuilder
        self.applyDetailBuilder = applyDetailBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func attachWriteApplyOverallRIB() {
        let writeApplyOverall = writeApplyOverallBuilder.build(withListener: interactor)
        
        self.writeApplyOverall = writeApplyOverall
        attachChild(writeApplyOverall)
        viewController.present(writeApplyOverall.viewControllable, isTabBarShow: false)
    }
    
    func attachApplyDetailRIB(apply: Apply) {
        let applyDetail = applyDetailBuilder.build(withListener: interactor, apply: apply)
        
        self.applyDetail = applyDetail
        attachChild(applyDetail)
        viewController.present(applyDetail.viewControllable, isTabBarShow: false)
    }
    
    func detachApplyDetailRIB() {
        if let applyDetail = applyDetail {
            detachChild(applyDetail)
        }
        viewController.dismiss(nil, isTabBarShow: true)
    }
    
    func detachWriteApplyOverallRIB() {
        if let writeApplyOverall = writeApplyOverall {
            detachChild(writeApplyOverall)
        }
        viewController.dismiss(nil, isTabBarShow: true)
    }
}
