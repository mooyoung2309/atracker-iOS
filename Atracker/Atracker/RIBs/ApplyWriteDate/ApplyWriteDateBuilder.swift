//
//  ApplyWriteDateBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs

protocol ApplyWriteDateDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ApplyWriteDateComponent: Component<ApplyWriteDateDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ApplyWriteDateBuildable: Buildable {
    func build(withListener listener: ApplyWriteDateListener) -> ApplyWriteDateRouting
}

final class ApplyWriteDateBuilder: Builder<ApplyWriteDateDependency>, ApplyWriteDateBuildable {

    override init(dependency: ApplyWriteDateDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ApplyWriteDateListener) -> ApplyWriteDateRouting {
        let component = ApplyWriteDateComponent(dependency: dependency)
        let viewController = ApplyWriteDateViewController()
        let interactor = ApplyWriteDateInteractor(presenter: viewController)
        interactor.listener = listener
        return ApplyWriteDateRouter(interactor: interactor, viewController: viewController)
    }
}
