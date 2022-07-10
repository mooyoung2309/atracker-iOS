//
//  TabBarRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs

protocol TabBarInteractable: Interactable, BlogListener, ApplyListener, ScheduleListener {
    var router: TabBarRouting? { get set }
    var listener: TabBarListener? { get set }
}

protocol TabBarViewControllable: NavigationContainerViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class TabBarRouter: ViewableRouter<TabBarInteractable, TabBarViewControllable>, TabBarRouting {
    
    private let blogBuilder: BlogBuildable
    private let applyBuilder: ApplyBuildable
    private let scheduleBuilder: ScheduleBuildable
    
    private var child: Routing?
    private var blog: ViewableRouting?
    private var apply: ViewableRouting?
    private var schedule: ViewableRouting?
    
    init(interactor: TabBarInteractable,
         viewController: TabBarViewControllable,
         blogBuilder: BlogBuildable,
         applyBuilder: ApplyBuildable,
         scheduleBuilder: ScheduleBuildable) {
        
        self.blogBuilder = blogBuilder
        self.applyBuilder = applyBuilder
        self.scheduleBuilder = scheduleBuilder
        
        self.blog = blogBuilder.build(withListener: interactor)
        self.apply = applyBuilder.build(withListener: interactor)
        self.schedule = scheduleBuilder.build(withListener: interactor)
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func detachChildRIB() {
        guard let child = child else { return }
        
        detachChild(child)
    }
    
    func attachBlogRIB() {
        detachChildRIB()
        
        if let _ = blog { } else {
            self.blog = blogBuilder.build(withListener: interactor)
        }
        
        guard let blog = blog else { return }
        
        attachChild(blog)
        viewController.presentView(blog, animation: false)
        child = blog
    }
    
    func attachApplyRIB() {
        detachChildRIB()
        
        if let _ = apply { } else {
            self.apply = applyBuilder.build(withListener: interactor)
        }
        
        guard let apply = apply else { return }
        
        attachChild(apply)
        viewController.presentView(apply, animation: false)
        
        child = apply
    }
    
    func attachPlanRIB() {
        detachChildRIB()
        
        if let _ = schedule { } else {
            self.schedule = scheduleBuilder.build(withListener: interactor)
        }
        
        guard let schedule = schedule else { return }
        
        attachChild(schedule)
        viewController.presentView(schedule, animation: false)
        
        child = schedule
    }
    
    func detachApplyRIB() {
        Log("[SIGNOUT] start")
        detachChildRIB(apply)
//        viewController.dismiss(viewController: apply.viewControllable)
        child = nil
        
        Log("[SIGNOUT] end")
    }
    
//    func attachApplyWriteRIB() {
//        let applyWrite = writeApplyOverallBuilder.build(withListener: interactor)
//        
//        self.writeApplyOverall = applyWrite
//        
//        detachChildRIB()
//        attachChild(applyWrite)
//        viewController.present(viewController: applyWrite.viewControllable)
//        
//        child = applyWrite
//    }
    
//    func attachApplyRIBfromOtherRIB() {
//        if let applyWrite = writeApplyOverall {
//            viewController.dismiss(viewController: applyWrite.viewControllable)
//        }
//        
//        let apply = applyBuilder.build(withListener: interactor)
//        self.apply = apply
//        
//        detachChildRIB()
//        attachChild(apply)
//        
//        viewController.presentView(apply, transitionSubType: .fromLeft)
//        
//        child = apply
//    }
    
//    func attachWriteApplyOverallRIBfromOtherRIB() {
//        if let applyWrite = writeApplyOverall {
//            viewController.dismiss(viewController: applyWrite.viewControllable)
//        }
//        let writeApplyOverall = writeApplyOverallBuilder.build(withListener: interactor)
//
//        self.writeApplyOverall = writeApplyOverall
//
//        detachChildRIB()
//        attachChild(writeApplyOverall)
//
//        viewController.present(viewController: writeApplyOverall.viewControllable)
//        viewController.uiviewController.view.layoutIfNeeded()
//
//        child = writeApplyOverall
//
//        Log("2")
//    }
}
