//
//  SignOutComponent+SignUpNickname.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import RIBs

/// The dependencies needed from the parent scope of SignOut to provide for the SignUpNickname scope.
// TODO: Update SignOutDependency protocol to inherit this protocol.
protocol SignOutDependencySignUpNickname: Dependency {
    // TODO: Declare dependencies needed from the parent scope of SignOut to provide dependencies
    // for the SignUpNickname scope.
}

extension SignOutComponent: SignUpNicknameDependency {

    // TODO: Implement properties to provide for SignUpNickname scope.
}
