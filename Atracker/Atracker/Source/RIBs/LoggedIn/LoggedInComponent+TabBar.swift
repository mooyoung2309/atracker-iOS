//
//  LoggedInComponent+TabBar.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs

/// The dependencies needed from the parent scope of LoggedIn to provide for the TabBar scope.
// TODO: Update LoggedInDependency protocol to inherit this protocol.
protocol LoggedInDependencyTabBar: Dependency {
    // TODO: Declare dependencies needed from the parent scope of LoggedIn to provide dependencies
    // for the TabBar scope.
}

extension LoggedInComponent: TabBarDependency {

    // TODO: Implement properties to provide for TabBar scope.
}
