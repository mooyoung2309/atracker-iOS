//
//  ApplyDetailBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs

protocol ApplyDetailDependency: Dependency {
    
}

final class ApplyDetailComponent: Component<ApplyDetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    
    let apply: ApplyResponse?
    
    init(dependency: ApplyDetailDependency, apply: ApplyResponse) {
        self.apply = apply
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol ApplyDetailBuildable: Buildable {
    func build(withListener listener: ApplyDetailListener, apply: ApplyResponse) -> ApplyDetailRouting
}

final class ApplyDetailBuilder: Builder<ApplyDetailDependency>, ApplyDetailBuildable {

    override init(dependency: ApplyDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ApplyDetailListener, apply: ApplyResponse) -> ApplyDetailRouting {
        let component = ApplyDetailComponent(dependency: dependency, apply: apply)
        let viewController = ApplyDetailViewController()
        let interactor = ApplyDetailInteractor(presenter: viewController, apply: apply)
        let applyEditBuilder = ApplyEditBuilder(dependency: component)
        let editApplyOverallBuilder = EditApplyOverallBuilder(dependency: component)
        let editApplyStageProgressBuilder = EditApplyStageProgressBuilder(dependency: component)
        
        interactor.listener = listener
        
        return ApplyDetailRouter(interactor: interactor, viewController: viewController, applyEditBuilder: applyEditBuilder, editApplyOverallBuilder: editApplyOverallBuilder, editApplyStageProgressBuilder: editApplyStageProgressBuilder)
    }
}
