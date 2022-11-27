//
//  WriteApplyOverallComponent+WriteApplySchedule.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/20.
//

import RIBs

/// The dependencies needed from the parent scope of WriteApplyOverall to provide for the WriteApplySchedule scope.
// TODO: Update WriteApplyOverallDependency protocol to inherit this protocol.
protocol ApplyWriteOverallDependencyWriteApplySchedule: Dependency {
    // TODO: Declare dependencies needed from the parent scope of WriteApplyOverall to provide dependencies
    // for the WriteApplySchedule scope.
}

extension ApplyWriteOverallComponent: ApplyWriteScheduleDependency {

    // TODO: Implement properties to provide for WriteApplySchedule scope.
}
