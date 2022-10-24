//
//  ApplyDetailBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs

protocol ApplyDetailDependency: Dependency {
    var applyService: ApplyServiceProtocolISOLDCODE { get }
}

final class ApplyDetailComponent: Component<ApplyDetailDependency> {
    
    var applyService: ApplyServiceProtocolISOLDCODE {
        return dependency.applyService
    }
}

// MARK: - Builder

protocol ApplyDetailBuildable: Buildable {
    func build(withListener listener: ApplyDetailListener, apply: Apply) -> ApplyDetailRouting
}

final class ApplyDetailBuilder: Builder<ApplyDetailDependency>, ApplyDetailBuildable {

    override init(dependency: ApplyDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ApplyDetailListener, apply: Apply) -> ApplyDetailRouting {
        let component = ApplyDetailComponent(dependency: dependency)
        let viewController = ApplyDetailViewController()
        let interactor = ApplyDetailInteractor(presenter: viewController, applyService: component.applyService, apply: apply)
        let editApplyOverallBuilder = EditApplyOverallBuilder(dependency: component)
        let editApplyStageProgressBuilder = EditApplyStageProgressBuilder(dependency: component)
        
        interactor.listener = listener
        
        return ApplyDetailRouter(interactor: interactor, viewController: viewController, editApplyOverallBuilder: editApplyOverallBuilder, editApplyStageProgressBuilder: editApplyStageProgressBuilder)
    }
}
