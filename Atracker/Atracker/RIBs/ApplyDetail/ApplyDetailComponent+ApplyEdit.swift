//
//  ApplyDetailComponent+ApplyEdit.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/13.
//

import RIBs

/// The dependencies needed from the parent scope of ApplyDetail to provide for the ApplyEdit scope.
// TODO: Update ApplyDetailDependency protocol to inherit this protocol.
protocol ApplyDetailDependencyApplyEdit: Dependency {
    // TODO: Declare dependencies needed from the parent scope of ApplyDetail to provide dependencies
    // for the ApplyEdit scope.
}

extension ApplyDetailComponent: ApplyEditDependency {

    // TODO: Implement properties to provide for ApplyEdit scope.
}
