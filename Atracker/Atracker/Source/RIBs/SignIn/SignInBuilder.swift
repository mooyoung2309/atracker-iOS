//
//  SignInBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import RIBs

protocol SignInDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var SignInViewController: SignInViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class SignInComponent: Component<SignInDependency> {

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var SignInViewController: SignInViewControllable {
        return dependency.SignInViewController
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SignInBuildable: Buildable {
    func build(withListener listener: SignInListener) -> SignInRouting
}

final class SignInBuilder: Builder<SignInDependency>, SignInBuildable {

    override init(dependency: SignInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SignInListener) -> SignInRouting {
        let component       = SignInComponent(dependency: dependency)
        let interactor      = SignInInteractor()
        let tabBarBuilder   = TabBarBuilder(dependency: component)
        
        interactor.listener = listener
        
        return SignInRouter(interactor: interactor, viewController: component.SignInViewController, tabBarBuilder: tabBarBuilder)
    }
}
