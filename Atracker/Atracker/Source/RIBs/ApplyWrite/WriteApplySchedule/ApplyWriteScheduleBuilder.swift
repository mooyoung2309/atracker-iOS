//
//  WriteApplyScheduleBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/20.
//

import RIBs

protocol ApplyWriteScheduleDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var applyService: ApplyServiceProtocolISOLDCODE { get }
    
}

final class ApplyWriteScheduleComponent: Component<ApplyWriteScheduleDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB
    var applyService: ApplyServiceProtocolISOLDCODE {
        return dependency.applyService
    }
}

// MARK: - Builder

protocol ApplyWriteScheduleBuildable: Buildable {
    func build(withListener listener: ApplyWriteScheduleListener, company: Company, jobPosition: String, jobType: JobType, stages: [Stage]) -> ApplyWriteScheduleRouting
}

final class ApplyWriteScheduleBuilder: Builder<ApplyWriteScheduleDependency>, ApplyWriteScheduleBuildable {

    override init(dependency: ApplyWriteScheduleDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ApplyWriteScheduleListener, company: Company, jobPosition: String, jobType: JobType, stages: [Stage]) -> ApplyWriteScheduleRouting {
        let component = ApplyWriteScheduleComponent(dependency: dependency)
        let viewController = ApplyWriteScheduleViewController()
        let interactor = ApplyWriteScheduleInteractor(presenter: viewController, applyService: component.applyService, company: company, jobPosition: jobPosition, jobType: jobType, stages: stages)
        
        interactor.listener = listener
        
        return ApplyWriteScheduleRouter(interactor: interactor, viewController: viewController)
    }
}
