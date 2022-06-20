//
//  WriteApplyScheduleComponent+Schedule.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/20.
//

import RIBs

/// The dependencies needed from the parent scope of WriteApplySchedule to provide for the Schedule scope.
// TODO: Update WriteApplyScheduleDependency protocol to inherit this protocol.
protocol WriteApplyScheduleDependencySchedule: Dependency {
    // TODO: Declare dependencies needed from the parent scope of WriteApplySchedule to provide dependencies
    // for the Schedule scope.
}

extension WriteApplyScheduleComponent: ScheduleDependency {

    // TODO: Implement properties to provide for Schedule scope.
}
