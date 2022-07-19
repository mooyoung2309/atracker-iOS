//
//  MyPageBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/29.
//

import RIBs

protocol MyPageDependency: Dependency {
    var userService: UserServiceProtocol { get }
}

final class MyPageComponent: Component<MyPageDependency> {
    var userService: UserServiceProtocol {
        return dependency.userService
    }
}

// MARK: - Builder

protocol MyPageBuildable: Buildable {
    func build(withListener listener: MyPageListener) -> MyPageRouting
}

final class MyPageBuilder: Builder<MyPageDependency>, MyPageBuildable {

    override init(dependency: MyPageDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MyPageListener) -> MyPageRouting {
        let component = MyPageComponent(dependency: dependency)
        let viewController = MyPageViewController()
        let interactor = MyPageInteractor(presenter: viewController, userService: component.userService)
        interactor.listener = listener
        return MyPageRouter(interactor: interactor, viewController: viewController)
    }
}
