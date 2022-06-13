//
//  ApplyComponent+ApplyEdit.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs

/// The dependencies needed from the parent scope of Apply to provide for the ApplyEdit scope.
// TODO: Update ApplyDependency protocol to inherit this protocol.
protocol ApplyDependencyApplyEdit: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Apply to provide dependencies
    // for the ApplyEdit scope.
}

extension ApplyComponent: ApplyEditDependency {

    // TODO: Implement properties to provide for ApplyEdit scope.
}
