//
//  RootRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs

protocol RootInteractable: Interactable, SignInListener, SignOutListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: NavigationViewControllable {
    func present(_ viewController: UIViewController)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    private let signOutBuilder: SignOutBuildable
    private let signInBuilder: SignInBuildable
    
    private var child: Routing?
    private var signOut: ViewableRouting?
    private var signIn: Routing?
    
    init(interactor: RootInteractable, viewController: RootViewControllable, signOutBuilder: SignOutBuildable, signInBuilder: SignInBuildable) {
        
        self.signOutBuilder = signOutBuilder
        self.signInBuilder = signInBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        
        if let _ = UserDefaults.standard.string(forKey: UserDefaultKey.accessToken) {
            attachSignInRIB()
        } else {
            attachSignOutRIB()
        }
    }
    
    func attachSignOutRIB() {
        if let signOut = signOut {
            viewController.dismiss(nil, isTabBarShow: true)
        }
        
        let signOut = signOutBuilder.build(withListener: interactor)
        
        detachChildRIB(child)
        attachChild(signOut)
        let navigationViewController = UINavigationController(rootViewController: signOut.viewControllable.uiviewController)
        viewController.present(navigationViewController)
        
        self.signOut = signOut
        self.child = signOut
    }
    
    func attachSignInRIB() {
        if let signOut = signOut {
            viewController.dismiss(nil, isTabBarShow: true)
        }
        
        let signIn = signInBuilder.build(withListener: interactor)
        
        detachChildRIB(child)
        attachChild(signIn)
        
        self.signIn = signIn
        self.child = signIn
    }
}
