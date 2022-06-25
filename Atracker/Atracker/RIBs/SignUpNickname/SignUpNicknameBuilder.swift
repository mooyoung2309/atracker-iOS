//
//  SignUpNicknameBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import RIBs

protocol SignUpNicknameDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SignUpNicknameComponent: Component<SignUpNicknameDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SignUpNicknameBuildable: Buildable {
    func build(withListener listener: SignUpNicknameListener) -> SignUpNicknameRouting
}

final class SignUpNicknameBuilder: Builder<SignUpNicknameDependency>, SignUpNicknameBuildable {

    override init(dependency: SignUpNicknameDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SignUpNicknameListener) -> SignUpNicknameRouting {
        let component = SignUpNicknameComponent(dependency: dependency)
        let viewController = SignUpNicknameViewController()
        let interactor = SignUpNicknameInteractor(presenter: viewController)
        interactor.listener = listener
        return SignUpNicknameRouter(interactor: interactor, viewController: viewController)
    }
}
