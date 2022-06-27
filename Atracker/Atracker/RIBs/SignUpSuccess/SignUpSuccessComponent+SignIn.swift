//
//  SignUpSuccessComponent+SignIn.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import RIBs

/// The dependencies needed from the parent scope of SignUpSuccess to provide for the SignIn scope.
// TODO: Update SignUpSuccessDependency protocol to inherit this protocol.
protocol SignUpSuccessDependencySignIn: Dependency {
    // TODO: Declare dependencies needed from the parent scope of SignUpSuccess to provide dependencies
    // for the SignIn scope.
}

extension SignUpSuccessComponent: SignInDependency {
    var SignInViewController: SignInViewControllable {
        return signUpSuccessViewController
    }
    

    // TODO: Implement properties to provide for SignIn scope.
}
