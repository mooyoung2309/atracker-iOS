//
//  SignInRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import RIBs

protocol SignInInteractable: Interactable, TabBarListener {
    var router: SignInRouting? { get set }
    var listener: SignInListener? { get set }
}

protocol SignInViewControllable: NavigationViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
    func present(_ viewController: UIViewController)
}

final class SignInRouter: Router<SignInInteractable>, SignInRouting {

    private let tabBarBuilder: TabBarBuildable
    
    private var tabBar: ViewableRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: SignInInteractable, viewController: SignInViewControllable, tabBarBuilder: TabBarBuildable) {
        self.tabBarBuilder = tabBarBuilder
        self.viewController = viewController
        
        super.init(interactor: interactor)
        
        interactor.router = self
    }

    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
    }
    
    func attachTabBarRIB() {
        let tabBar = tabBarBuilder.build(withListener: interactor)
        
        self.tabBar = tabBar
        attachChild(tabBar)
        viewController.present(tabBar.viewControllable.uiviewController)
    }
    
    func detachTabBarRIB() {
        Log("[SIGNOUT] start")
        if let tabBar = tabBar {
            detachChild(tabBar)
            viewController.dismiss(tabBar.viewControllable, isTabBarShow: true)
        }
        
        tabBar = nil
        Log("[SIGNOUT] end")
    }

    // MARK: - Private

    private let viewController: SignInViewControllable
}
