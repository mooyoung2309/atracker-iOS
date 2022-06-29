//
//  RootComponent+SignOut.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/29.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the SignOut scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol RootDependencySignOut: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the SignOut scope.
}

extension RootComponent: SignOutDependency {

    // TODO: Implement properties to provide for SignOut scope.
}
