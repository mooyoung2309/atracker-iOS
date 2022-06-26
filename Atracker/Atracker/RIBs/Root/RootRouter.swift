//
//  RootRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs

protocol RootInteractable: Interactable, SignOutListener,LoggedOutListener, LoggedInListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func presentModal(viewController: ViewControllable)
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    private let loggedOutBuilder: LoggedOutBuildable
    private let loggedInBuilder: LoggedInBuildable
    private let signOutBuilder: SignOutBuildable
    
    private var signOut: ViewableRouting?
    private var loggedOut: ViewableRouting?
    
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         signOutBuilder: SignOutBuilder,
         loggedOutBuilder: LoggedOutBuilder,
         loggedInBuilder: LoggedInBuilder) {
        
        self.signOutBuilder = signOutBuilder
        self.loggedOutBuilder = loggedOutBuilder
        self.loggedInBuilder = loggedInBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        
        routeToSignOut()
    }
    
    func routeToSignOut() {
        let signOut = signOutBuilder.build(withListener: interactor)
        
        self.signOut = signOut
        attachChild(signOut)
        viewController.present(viewController: signOut.viewControllable)
    }
    
    func routeToLoggedIn(email: String?, password: String?) {
        if let loggedOut = loggedOut {
            detachChild(loggedOut)
            viewController.dismiss(viewController: loggedOut.viewControllable)
            
            self.loggedOut = nil
        }
        
        let loggedIn = loggedInBuilder.build(withListener: interactor, email: email, password: password)
        
        attachChild(loggedIn)
    }
    
    private func routeToLoggedOut() {
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        
        self.loggedOut = loggedOut
        
        attachChild(loggedOut)
        
        viewController.present(viewController: loggedOut.viewControllable)
    }
}
