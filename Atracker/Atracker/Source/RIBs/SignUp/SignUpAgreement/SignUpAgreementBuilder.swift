//
//  SignUpAgreementBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/19.
//

import RIBs

protocol SignUpAgreementDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SignUpAgreementComponent: Component<SignUpAgreementDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SignUpAgreementBuildable: Buildable {
    func build(withListener listener: SignUpAgreementListener, idToken: String, sso: SSO) -> SignUpAgreementRouting
}

final class SignUpAgreementBuilder: Builder<SignUpAgreementDependency>, SignUpAgreementBuildable {

    override init(dependency: SignUpAgreementDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SignUpAgreementListener, idToken: String, sso: SSO) -> SignUpAgreementRouting {
        let component = SignUpAgreementComponent(dependency: dependency)
        let viewController = SignUpAgreementViewController()
        let interactor = SignUpAgreementInteractor(presenter: viewController, idToken: idToken, sso: sso)
        let signUpNicknameBuilder = SignUpNicknameBuilder(dependency: component)
        let signUpAgreementDetailBuilder = SignUpAgreementDetailBuilder(dependency: component)
        interactor.listener = listener
        return SignUpAgreementRouter(interactor: interactor, viewController: viewController, signUpAgreementDetailBuilder: signUpAgreementDetailBuilder, signUpNicknameBuilder: signUpNicknameBuilder)
    }
}
