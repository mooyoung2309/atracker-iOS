//
//  SignOutBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs

protocol SignOutDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SignOutComponent: Component<SignOutDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SignOutBuildable: Buildable {
    func build(withListener listener: SignOutListener) -> SignOutRouting
}

final class SignOutBuilder: Builder<SignOutDependency>, SignOutBuildable {

    override init(dependency: SignOutDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SignOutListener) -> SignOutRouting {
        let component = SignOutComponent(dependency: dependency)
        let viewController = SignOutViewController()
        let interactor = SignOutInteractor(presenter: viewController)
        interactor.listener = listener
        return SignOutRouter(interactor: interactor, viewController: viewController)
    }
}
