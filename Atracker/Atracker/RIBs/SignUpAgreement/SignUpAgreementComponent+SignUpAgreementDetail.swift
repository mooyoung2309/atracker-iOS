//
//  SignUpAgreementComponent+SignUpAgreementDetail.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/24.
//

import RIBs

/// The dependencies needed from the parent scope of SignUpAgreement to provide for the SignUpAgreementDetail scope.
// TODO: Update SignUpAgreementDependency protocol to inherit this protocol.
protocol SignUpAgreementDependencySignUpAgreementDetail: Dependency {
    // TODO: Declare dependencies needed from the parent scope of SignUpAgreement to provide dependencies
    // for the SignUpAgreementDetail scope.
}

extension SignUpAgreementComponent: SignUpAgreementDetailDependency {

    // TODO: Implement properties to provide for SignUpAgreementDetail scope.
}
