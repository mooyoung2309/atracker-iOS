//
//  SignInComponent+TabBar.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import RIBs

/// The dependencies needed from the parent scope of SignIn to provide for the TabBar scope.
// TODO: Update SignInDependency protocol to inherit this protocol.
protocol SignInDependencyTabBar: Dependency {
    // TODO: Declare dependencies needed from the parent scope of SignIn to provide dependencies
    // for the TabBar scope.
}

extension SignInComponent: TabBarDependency {

    // TODO: Implement properties to provide for TabBar scope.
}
