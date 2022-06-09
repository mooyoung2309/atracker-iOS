//
//  LoggedInRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs

protocol LoggedInInteractable: Interactable, TabBarListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {
    
    private let tabBarBuilder: TabBarBuildable
    
    private var tabBar: ViewableRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: LoggedInInteractable,
         viewController: LoggedInViewControllable,
         tabBarBuilder: TabBarBuildable) {
        
        self.viewController = viewController
        self.tabBarBuilder = tabBarBuilder
        
        super.init(interactor: interactor)
        
        interactor.router = self
    }

    func cleanupViews() {
        
    }
    
    func routeToTabBar() {
        let tabBar = tabBarBuilder.build(withListener: interactor)
        
        self.tabBar = tabBar
        
        attachChild(tabBar)
        viewController.present(viewController: tabBar.viewControllable)
    }


    // MARK: - Private

    private let viewController: LoggedInViewControllable
}
