//
//  ApplyComponent+MyPage.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/29.
//

import RIBs

/// The dependencies needed from the parent scope of Apply to provide for the MyPage scope.
// TODO: Update ApplyDependency protocol to inherit this protocol.
protocol ApplyDependencyMyPage: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Apply to provide dependencies
    // for the MyPage scope.
}

extension ApplyComponent: MyPageDependency {

    // TODO: Implement properties to provide for MyPage scope.
}
