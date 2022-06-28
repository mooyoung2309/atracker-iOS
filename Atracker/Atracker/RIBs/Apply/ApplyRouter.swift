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

protocol ApplyViewControllable: NavigationContainerViewControllable {

}

final class ApplyRouter: ViewableRouter<ApplyInteractable, ApplyViewControllable>, ApplyRouting {
    
    private let writeApplyOverallBuilder: WriteApplyOverallBuildable
    private let applyDetailBuilder: ApplyDetailBuildable
    
    private var child: ViewableRouting?
    private var writeApplyOverall: ViewableRouting?
    private var applyDetail: ViewableRouting?
    private var apply: ApplyResponse?
    
    init(interactor: ApplyInteractable, viewController: ApplyViewControllable, applyWriteBuilder: WriteApplyOverallBuildable, applyDetailBuilder: ApplyDetailBuildable) {
        self.writeApplyOverallBuilder  = applyWriteBuilder
        self.applyDetailBuilder = applyDetailBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func attachApplyDetailRIB(apply: ApplyResponse) {
        self.apply = apply
        let applyDetail = applyDetailBuilder.build(withListener: interactor, apply: apply)
        self.applyDetail = applyDetail
        
        detachChildRIB(child)
        attachChild(applyDetail)
        viewController.presentView(applyDetail, animation: true, transitionSubType: .fromRight)
        
        child = applyDetail
    }
    
    func attachWriteApplyOverall() {
        let writeApplyOverall = writeApplyOverallBuilder.build(withListener: interactor)
        
        self.writeApplyOverall = writeApplyOverall
        
        detachChildRIB(child)
        attachChild(writeApplyOverall)
//        Log("[D] 탭바 안보이게")
        viewController.presentView(writeApplyOverall, animation: true)
        child = writeApplyOverall
    }
    
    func reAttachApplyDetailRIB() {
        guard let apply = apply else { return }
        let applyDetail = applyDetailBuilder.build(withListener: interactor, apply: apply)
        self.applyDetail = applyDetail
        
        detachChildRIB(child)
        attachChild(applyDetail)
        viewController.presentView(applyDetail, transitionSubType: .fromLeft)
        
        child = applyDetail
    }
    
    func detachThisChildRIB() {
        detachChildRIB(child)
        viewController.dismissView(animation: true)
    }
}
