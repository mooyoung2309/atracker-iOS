//
//  TabBarRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs

protocol TabBarInteractable: Interactable, BlogListener, ApplyListener, MyPageListener, ScheduleListener {
    var router: TabBarRouting? { get set }
    var listener: TabBarListener? { get set }
}

protocol TabBarViewControllable: NavigationViewControllable {
    func setupTabBar(blogViewController: UIViewController, applyViewController: UIViewController, myPageViewController: UIViewController, scheduleViewController: UIViewController)
}

final class TabBarRouter: ViewableRouter<TabBarInteractable, TabBarViewControllable>, TabBarRouting {
    
    private let blogBuilder: BlogBuildable
    private let applyBuilder: ApplyBuildable
    private let myPageBuilder: MyPageBuildable
    private let scheduleBuilder: ScheduleBuildable
    
    private var child: Routing?
    private var blog: ViewableRouting
    private var apply: ViewableRouting
    private var myPage: ViewableRouting
    private var schedule: ViewableRouting
    
    private var viewControllers: [UIViewController] = []
    
    init(interactor: TabBarInteractable, viewController: TabBarViewControllable, blogBuilder: BlogBuildable, applyBuilder: ApplyBuildable, myPageBuilder: MyPageBuildable, scheduleBuilder: ScheduleBuildable) {
        
        self.blogBuilder = blogBuilder
        self.applyBuilder = applyBuilder
        self.myPageBuilder = myPageBuilder
        self.scheduleBuilder = scheduleBuilder
        
        blog = blogBuilder.build(withListener: interactor)
        apply = applyBuilder.build(withListener: interactor)
        myPage = myPageBuilder.build(withListener: interactor)
        schedule = scheduleBuilder.build(withListener: interactor)
        
        self.viewControllers.append(contentsOf: [])
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
        
        viewController.setupTabBar(blogViewController: blog.viewControllable.uiviewController, applyViewController: apply.viewControllable.uiviewController, myPageViewController: myPage.viewControllable.uiviewController, scheduleViewController: schedule.viewControllable.uiviewController)
    }
    
    func attachBlogRIB() {
        if let child = child {
            detachChild(child)
        }
        attachChild(blog)
        child = blog
    }
    
    func attachApplyRIB() {
        if let child = child {
            detachChild(child)
        }
        attachChild(apply)
        child = apply
    }
    
    func attachMyPageRIB() {
        if let child = child {
            detachChild(child)
        }
        attachChild(myPage)
        child = myPage
    }
    
    func attachScheduleRIB() {
        if let child = child {
            detachChild(child)
        }
        attachChild(schedule)
        child = schedule
    }
    
    func detachApplyRIB() {
        detachChildRIB(apply)
        child = nil
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
