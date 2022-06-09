//
//  TabBarComponent+Plan.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs

/// The dependencies needed from the parent scope of TabBar to provide for the Plan scope.
// TODO: Update TabBarDependency protocol to inherit this protocol.
protocol TabBarDependencyPlan: Dependency {
    // TODO: Declare dependencies needed from the parent scope of TabBar to provide dependencies
    // for the Plan scope.
}

extension TabBarComponent: PlanDependency {

    // TODO: Implement properties to provide for Plan scope.
}
