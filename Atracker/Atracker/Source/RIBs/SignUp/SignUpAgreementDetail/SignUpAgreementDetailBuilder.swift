//
//  SignUpAgreementDetailBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/24.
//

import RIBs

protocol SignUpAgreementDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SignUpAgreementDetailComponent: Component<SignUpAgreementDetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SignUpAgreementDetailBuildable: Buildable {
    func build(withListener listener: SignUpAgreementDetailListener, agreementType: AgreementType) -> SignUpAgreementDetailRouting
}

final class SignUpAgreementDetailBuilder: Builder<SignUpAgreementDetailDependency>, SignUpAgreementDetailBuildable {

    override init(dependency: SignUpAgreementDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SignUpAgreementDetailListener, agreementType: AgreementType) -> SignUpAgreementDetailRouting {
        let component = SignUpAgreementDetailComponent(dependency: dependency)
        let viewController = SignUpAgreementDetailViewController()
        let interactor = SignUpAgreementDetailInteractor(presenter: viewController, agreementType: agreementType)
        interactor.listener = listener
        return SignUpAgreementDetailRouter(interactor: interactor, viewController: viewController)
    }
}
