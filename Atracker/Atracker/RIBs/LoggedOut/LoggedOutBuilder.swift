//
//  LoggedOutBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs

protocol LoggedOutDependency: Dependency {
    
}

final class LoggedOutComponent: Component<LoggedOutDependency> {
    
    var authService: AuthServiceProtocol {
        return AuthService()
    }
}

protocol LoggedOutBuildable: Buildable {
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting
}

final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {
    
    override init(dependency: LoggedOutDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
        let component       = LoggedOutComponent(dependency: dependency)
        let viewController  = LoggedOutViewController()
        let interactor      = LoggedOutInteractor(presenter: viewController,
                                                  authService: component.authService)
        interactor.listener = listener
        
        return LoggedOutRouter(interactor: interactor,
                               viewController: viewController)
    }
}
