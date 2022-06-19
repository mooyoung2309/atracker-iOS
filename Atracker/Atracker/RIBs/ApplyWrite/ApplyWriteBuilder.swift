//
//  ApplyWriteBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs

protocol ApplyWriteDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ApplyWriteComponent: Component<ApplyWriteDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ApplyWriteBuildable: Buildable {
    func build(withListener listener: ApplyWriteListener) -> ApplyWriteRouting
}

final class ApplyWriteBuilder: Builder<ApplyWriteDependency>, ApplyWriteBuildable {

    override init(dependency: ApplyWriteDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ApplyWriteListener) -> ApplyWriteRouting {
        let component = ApplyWriteComponent(dependency: dependency)
        let viewController = ApplyWriteViewController()
        let interactor = ApplyWriteInteractor(presenter: viewController)
        interactor.listener = listener
        return ApplyWriteRouter(interactor: interactor, viewController: viewController)
    }
}
