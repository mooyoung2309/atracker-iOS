//
//  TabBarComponent+Blog.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs

/// The dependencies needed from the parent scope of TabBar to provide for the Blog scope.
// TODO: Update TabBarDependency protocol to inherit this protocol.
protocol TabBarDependencyBlog: Dependency {
    // TODO: Declare dependencies needed from the parent scope of TabBar to provide dependencies
    // for the Blog scope.
}

extension TabBarComponent: BlogDependency {

    // TODO: Implement properties to provide for Blog scope.
}
