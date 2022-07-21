//
//  SignOutComponent+SignUpAgreement.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/19.
//

import RIBs

/// The dependencies needed from the parent scope of SignOut to provide for the SignUpAgreement scope.
// TODO: Update SignOutDependency protocol to inherit this protocol.
protocol SignOutDependencySignUpAgreement: Dependency {
    // TODO: Declare dependencies needed from the parent scope of SignOut to provide dependencies
    // for the SignUpAgreement scope.
}

extension SignOutComponent: SignUpAgreementDependency {

    // TODO: Implement properties to provide for SignUpAgreement scope.
}
