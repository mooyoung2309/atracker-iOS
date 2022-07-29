//
//  TabBarComponent+MyPage.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/18.
//

import RIBs

/// The dependencies needed from the parent scope of TabBar to provide for the MyPage scope.
// TODO: Update TabBarDependency protocol to inherit this protocol.
protocol TabBarDependencyMyPage: Dependency {
    // TODO: Declare dependencies needed from the parent scope of TabBar to provide dependencies
    // for the MyPage scope.
}

extension TabBarComponent: MyPageDependency {

    // TODO: Implement properties to provide for MyPage scope.
}
