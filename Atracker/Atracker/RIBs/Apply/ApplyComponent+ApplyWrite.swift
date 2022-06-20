//
//  ApplyComponent+ApplyWrite.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs

/// The dependencies needed from the parent scope of Apply to provide for the ApplyWrite scope.
// TODO: Update ApplyDependency protocol to inherit this protocol.
protocol ApplyDependencyApplyWrite: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Apply to provide dependencies
    // for the ApplyWrite scope.
}

extension ApplyComponent: WriteApplyOverallDependency {

    // TODO: Implement properties to provide for ApplyWrite scope.
}
