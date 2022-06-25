//
//  SignUpPositionBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs

protocol SignUpPositionDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SignUpPositionComponent: Component<SignUpPositionDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SignUpPositionBuildable: Buildable {
    func build(withListener listener: SignUpPositionListener) -> SignUpPositionRouting
}

final class SignUpPositionBuilder: Builder<SignUpPositionDependency>, SignUpPositionBuildable {

    override init(dependency: SignUpPositionDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SignUpPositionListener) -> SignUpPositionRouting {
        let component = SignUpPositionComponent(dependency: dependency)
        let viewController = SignUpPositionViewController()
        let interactor = SignUpPositionInteractor(presenter: viewController)
        interactor.listener = listener
        return SignUpPositionRouter(interactor: interactor, viewController: viewController)
    }
}
