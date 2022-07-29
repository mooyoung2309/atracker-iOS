//
//  ApplyComponent+ApplyDetail.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/11.
//

import RIBs

/// The dependencies needed from the parent scope of Apply to provide for the ApplyDetail scope.
// TODO: Update ApplyDependency protocol to inherit this protocol.
protocol ApplyDependencyApplyDetail: Dependency {

}

extension ApplyComponent: ApplyDetailDependency {
    
}
