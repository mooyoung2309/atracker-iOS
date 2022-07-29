//
//  TabBarComponent+NewMyPage.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/29.
//

import RIBs

/// The dependencies needed from the parent scope of TabBar to provide for the NewMyPage scope.
// TODO: Update TabBarDependency protocol to inherit this protocol.
protocol TabBarDependencyNewMyPage: Dependency {
    // TODO: Declare dependencies needed from the parent scope of TabBar to provide dependencies
    // for the NewMyPage scope.
}

extension TabBarComponent: NewMyPageDependency {

    // TODO: Implement properties to provide for NewMyPage scope.
}
