//
//  ApplyDetailComponent+EditApplyOverall.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/05.
//

import RIBs

/// The dependencies needed from the parent scope of ApplyDetail to provide for the EditApplyOverall scope.
// TODO: Update ApplyDetailDependency protocol to inherit this protocol.
protocol ApplyDetailDependencyEditApplyOverall: Dependency {
    // TODO: Declare dependencies needed from the parent scope of ApplyDetail to provide dependencies
    // for the EditApplyOverall scope.
}

extension ApplyDetailComponent: EditApplyOverallDependency {

    // TODO: Implement properties to provide for EditApplyOverall scope.
}
