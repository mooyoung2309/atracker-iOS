//
//  ApplyDetailComponent+EditApplyStageProgress.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/05.
//

import RIBs

/// The dependencies needed from the parent scope of ApplyDetail to provide for the EditApplyStageProgress scope.
// TODO: Update ApplyDetailDependency protocol to inherit this protocol.
protocol ApplyDetailDependencyEditApplyStageProgress: Dependency {
    // TODO: Declare dependencies needed from the parent scope of ApplyDetail to provide dependencies
    // for the EditApplyStageProgress scope.
}

extension ApplyDetailComponent: EditApplyStageProgressDependency {

    // TODO: Implement properties to provide for EditApplyStageProgress scope.
}
