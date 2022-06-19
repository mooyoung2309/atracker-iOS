//
//  TabBarComponent+ApplyWrite.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs

/// The dependencies needed from the parent scope of TabBar to provide for the ApplyWrite scope.
// TODO: Update TabBarDependency protocol to inherit this protocol.
protocol TabBarDependencyApplyWrite: Dependency {
    // TODO: Declare dependencies needed from the parent scope of TabBar to provide dependencies
    // for the ApplyWrite scope.
}

extension TabBarComponent: ApplyWriteDependency {

    // TODO: Implement properties to provide for ApplyWrite scope.
}
