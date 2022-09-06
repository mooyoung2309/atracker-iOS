//
//  WriteApplyScheduleBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/20.
//

import RIBs

protocol WriteApplyScheduleDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var applyService: ApplyServiceProtocolISOLDCODE { get }
    
}

final class WriteApplyScheduleComponent: Component<WriteApplyScheduleDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB
    var applyService: ApplyServiceProtocolISOLDCODE {
        return dependency.applyService
    }
}

// MARK: - Builder

protocol WriteApplyScheduleBuildable: Buildable {
    func build(withListener listener: WriteApplyScheduleListener, applyCreateRequest: ApplyCreateRequest, stages: [Stage]) -> WriteApplyScheduleRouting
}

final class WriteApplyScheduleBuilder: Builder<WriteApplyScheduleDependency>, WriteApplyScheduleBuildable {

    override init(dependency: WriteApplyScheduleDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: WriteApplyScheduleListener, applyCreateRequest: ApplyCreateRequest, stages: [Stage]) -> WriteApplyScheduleRouting {
        let component = WriteApplyScheduleComponent(dependency: dependency)
        let viewController = WriteApplyScheduleViewController()
        let interactor = WriteApplyScheduleInteractor(presenter: viewController, applyService: component.applyService, applyCreateRequest: applyCreateRequest, stages: stages)
        
        interactor.listener = listener
        
        return WriteApplyScheduleRouter(interactor: interactor, viewController: viewController)
    }
}
