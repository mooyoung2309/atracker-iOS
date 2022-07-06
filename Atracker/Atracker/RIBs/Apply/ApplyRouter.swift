//
//  ApplyRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs

protocol ApplyInteractable: Interactable, ApplyDetailListener, WriteApplyOverallListener, MyPageListener {
    var router: ApplyRouting? { get set }
    var listener: ApplyListener? { get set }
}

protocol ApplyViewControllable: NavigationContainerViewControllable {

}

final class ApplyRouter: ViewableRouter<ApplyInteractable, ApplyViewControllable>, ApplyRouting {
    
    private let writeApplyOverallBuilder: WriteApplyOverallBuildable
    private let applyDetailBuilder: ApplyDetailBuildable
    private let myPageBuilder: MyPageBuildable
    
    private var child: ViewableRouting?
    private var writeApplyOverall: ViewableRouting?
    private var applyDetail: ViewableRouting?
    private var myPage: ViewableRouting?
    private var apply: Apply?
    
    init(interactor: ApplyInteractable, viewController: ApplyViewControllable, applyWriteBuilder: WriteApplyOverallBuildable, applyDetailBuilder: ApplyDetailBuildable, myPageBuilder: MyPageBuildable) {
        self.writeApplyOverallBuilder  = applyWriteBuilder
        self.applyDetailBuilder = applyDetailBuilder
        self.myPageBuilder = myPageBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func attachApplyDetailRIB(apply: Apply) {
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
        viewController.presentView(writeApplyOverall, animation: true)
        child = writeApplyOverall
    }
    
    func attachMyPageRIB() {
        let myPage = myPageBuilder.build(withListener: interactor)
        
        self.myPage = myPage
        
        detachChildRIB(child)
        attachChild(myPage)
        viewController.presentView(myPage, animation: true)
        
        child = myPage
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
        Log("[D] ")
        detachChildRIB(child)
        viewController.dismissView(animation: true)
    }
}
