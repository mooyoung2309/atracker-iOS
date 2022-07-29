//
//  NewMyPageBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/29.
//

import RIBs

protocol NewMyPageDependency: Dependency {
    var userService: UserServiceProtocol { get }
}

final class NewMyPageComponent: Component<NewMyPageDependency> {
    var authService: AuthServiceProtocol {
        return AuthService()
    }
    var userService: UserServiceProtocol {
        return dependency.userService
    }
}

// MARK: - Builder

protocol NewMyPageBuildable: Buildable {
    func build(withListener listener: NewMyPageListener) -> NewMyPageRouting
}

final class NewMyPageBuilder: Builder<NewMyPageDependency>, NewMyPageBuildable {

    override init(dependency: NewMyPageDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: NewMyPageListener) -> NewMyPageRouting {
        let component = NewMyPageComponent(dependency: dependency)
        let viewController = NewMyPageViewController()
        let interactor = NewMyPageInteractor(presenter: viewController, authService: component.authService, userService: component.userService)
        interactor.listener = listener
        return NewMyPageRouter(interactor: interactor, viewController: viewController)
    }
}
