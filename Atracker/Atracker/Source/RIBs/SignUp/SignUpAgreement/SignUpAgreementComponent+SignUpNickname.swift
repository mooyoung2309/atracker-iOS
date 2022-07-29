//
//  SignUpAgreementComponent+SignUpNickname.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/21.
//

import RIBs

/// The dependencies needed from the parent scope of SignUpAgreement to provide for the SignUpNickname scope.
// TODO: Update SignUpAgreementDependency protocol to inherit this protocol.
protocol SignUpAgreementDependencySignUpNickname: Dependency {
    // TODO: Declare dependencies needed from the parent scope of SignUpAgreement to provide dependencies
    // for the SignUpNickname scope.
}

extension SignUpAgreementComponent: SignUpNicknameDependency {

    // TODO: Implement properties to provide for SignUpNickname scope.
}
