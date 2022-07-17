//
//  RootComponent+SignIn.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/28.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the SignIn scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol RootDependencySignIn: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the SignIn scope.
}

extension RootComponent: SignInDependency {
    var SignInViewController: SignInViewControllable {
        return rootViewController
    }
}
