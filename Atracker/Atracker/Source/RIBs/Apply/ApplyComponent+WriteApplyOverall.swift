//
//  ApplyComponent+WriteApplyOverall.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/26.
//

import RIBs

/// The dependencies needed from the parent scope of Apply to provide for the WriteApplyOverall scope.
// TODO: Update ApplyDependency protocol to inherit this protocol.
protocol ApplyDependencyWriteApplyOverall: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Apply to provide dependencies
    // for the WriteApplyOverall scope.
}

extension ApplyComponent: ApplyWriteOverallDependency {

    // TODO: Implement properties to provide for WriteApplyOverall scope.
}
