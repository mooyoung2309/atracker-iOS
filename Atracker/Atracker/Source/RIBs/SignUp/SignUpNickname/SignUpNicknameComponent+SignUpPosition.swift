//
//  SignUpNicknameComponent+SignUpPosition.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import RIBs

/// The dependencies needed from the parent scope of SignUpNickname to provide for the SignUpPosition scope.
// TODO: Update SignUpNicknameDependency protocol to inherit this protocol.
protocol SignUpNicknameDependencySignUpPosition: Dependency {
    // TODO: Declare dependencies needed from the parent scope of SignUpNickname to provide dependencies
    // for the SignUpPosition scope.
}

extension SignUpNicknameComponent: SignUpPositionDependency {

    // TODO: Implement properties to provide for SignUpPosition scope.
}
