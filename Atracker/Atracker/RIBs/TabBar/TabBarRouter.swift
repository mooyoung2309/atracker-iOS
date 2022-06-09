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
    
    private var current: Routing?
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
    
    func routeToBlog() {
        if let current = current {
            detachChild(current)
        }
        current = blog
        attachChild(blog)
        viewController.replace(rib: blog)
    }
    
    func routeToApply() {
        if let current = current {
            detachChild(current)
        }
        current = apply
        attachChild(apply)
        viewController.replace(rib: apply)
    }
    
    func routeToPlan() {
        if let current = current {
            detachChild(current)
        }
        current = plan
        attachChild(plan)
        viewController.replace(rib: plan)
    }
    
//    func routeToBlog() {
//        var blogRouting: BlogRouting!
//
//        if let blog = self.blog as? BlogRouting {
//            blogRouting = blog
//        } else {
//            blogRouting = blogBuilder.build(withListener: interactor)
//            blog = blogRouting
//        }
//        detachChild(<#T##child: Routing##Routing#>)
//        attachChild(blogRouting)
//        viewController.replace(rib: blogRouting)
//    }
//
//    func routeToApply() {
//        var applyRouting: ApplyRouting!
//
//        if let apply = self.apply as? ApplyRouting {
//            applyRouting = apply
//        } else {
//            applyRouting = applyBuilder.build(withListener: interactor)
//            apply = applyRouting
//        }
//
//        attachChild(applyRouting)
//        viewController.replace(rib: applyRouting)
////        viewController.present(viewController: applyRouting.viewControllable)
//    }
//
//    func routeToPlan() {
//        var planRouting: PlanRouting!
//
//        if let plan = self.plan as? PlanRouting {
//            planRouting = plan
//        } else {
//            planRouting = planBuilder.build(withListener: interactor)
//            plan = planRouting
//        }
//
//        attachChild(planRouting)
//        viewController.replace(rib: planRouting)
////        viewController.present(viewController: planRouting.viewControllable)
//    }
}
