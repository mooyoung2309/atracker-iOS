//
//  TabBarRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs

protocol TabBarInteractable: Interactable, BlogListener, ApplyListener, PlanListener {
    var router: TabBarRouting? { get set }
    var listener: TabBarListener? { get set }
}

protocol TabBarViewControllable: ContainerViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class TabBarRouter: ViewableRouter<TabBarInteractable, TabBarViewControllable>, TabBarRouting {
    private let blogBuilder: BlogBuildable
    private let applyBuilder: ApplyBuildable
    private let planBuilder: PlanBuildable
    
    private var child: Routing?
    private var blog: ViewableRouting
    private var apply: ViewableRouting
    private var plan: ViewableRouting
    
    init(interactor: TabBarInteractable,
                  viewController: TabBarViewControllable,
                  blogBuilder: BlogBuildable,
                  applyBuilder: ApplyBuildable,
                  planBuilder: PlanBuildable) {
        
        self.blogBuilder    = blogBuilder
        self.applyBuilder   = applyBuilder
        self.planBuilder    = planBuilder
        
        self.blog = blogBuilder.build(withListener: interactor)
        self.apply = applyBuilder.build(withListener: interactor)
        self.plan = planBuilder.build(withListener: interactor)
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    func detachChildRIB() {
        guard let child = child else { return }
        
        detachChild(child)
    }
    
    func attachBlogRIB() {
        detachChildRIB()
        attachChild(blog)
        viewController.replace(viewController: blog.viewControllable.uiviewController)
        
        child = blog
    }
    
    func attachApplyRIB() {
        detachChildRIB()
        attachChild(apply)
        viewController.replace(viewController: apply.viewControllable.uiviewController)
        
        child = apply
    }
    
    func attachPlanRIB() {
        detachChildRIB()
        attachChild(plan)
        viewController.replace(viewController: plan.viewControllable.uiviewController)
        
        child = plan
    }
    
    func attachApplyRIBfromOtherRIB() {
        let apply = applyBuilder.build(withListener: interactor)
        self.apply = apply
        
        detachChildRIB()
        attachChild(apply)
        viewController.replace(viewController: apply.viewControllable.uiviewController,
                               transitionSubType: .fromLeft)
        
        child = apply
    }
}
