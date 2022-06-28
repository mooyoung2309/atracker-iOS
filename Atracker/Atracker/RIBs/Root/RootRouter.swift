//
//  RootRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs

protocol RootInteractable: Interactable, SignOutListener, SignInListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func presentModal(viewController: ViewControllable)
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    private let signOutBuilder: SignOutBuildable
    private let signInBuilder: SignInBuildable
    
    private var signOut: ViewableRouting?
    
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
        let signOut = signOutBuilder.build(withListener: interactor)
        
        self.signOut = signOut
        attachChild(signOut)
        viewController.present(viewController: signOut.viewControllable)
    }
    
    func attachSignInRIB() {
        let signIn = signInBuilder.build(withListener: interactor)
        
        attachChild(signIn)
    }
}
