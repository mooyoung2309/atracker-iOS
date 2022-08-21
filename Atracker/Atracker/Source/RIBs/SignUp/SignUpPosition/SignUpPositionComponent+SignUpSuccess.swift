//
//  SignUpPositionComponent+SignUpSuccess.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import RIBs

/// The dependencies needed from the parent scope of SignUpPosition to provide for the SignUpSuccess scope.
// TODO: Update SignUpPositionDependency protocol to inherit this protocol.
protocol SignUpPositionDependencySignUpSuccess: Dependency {
    // TODO: Declare dependencies needed from the parent scope of SignUpPosition to provide dependencies
    // for the SignUpSuccess scope.
}

extension SignUpPositionComponent: SignUpSuccessDependency {

    // TODO: Implement properties to provide for SignUpSuccess scope.
}
