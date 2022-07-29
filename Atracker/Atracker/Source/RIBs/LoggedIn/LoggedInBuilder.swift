//
//  LoggedInBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs

protocol LoggedInDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var LoggedInViewController: LoggedInViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class LoggedInComponent: Component<LoggedInDependency> {

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var LoggedInViewController: LoggedInViewControllable {
        return dependency.LoggedInViewController
    }
    
    let email: String?
    let password: String?
    
    init(dependency: LoggedInDependency, email: String?, password: String?) {
        self.email = email
        self.password = password
        super.init(dependency: dependency)
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener, email: String?, password: String?) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {

    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedInListener, email: String?, password: String?) -> LoggedInRouting {
        
        let component       = LoggedInComponent(dependency: dependency, email: email, password: password)
        let interactor      = LoggedInInteractor()
        let tabBarBuilder   = TabBarBuilder(dependency: component)
        
        interactor.listener = listener
        
        return LoggedInRouter(interactor: interactor, viewController: component.LoggedInViewController, tabBarBuilder: tabBarBuilder)
    }
}
