//
//  ApplyWriteBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs

protocol ApplyWriteOverallDependency: Dependency {
    var applyService: ApplyServiceProtocol { get }
}

final class ApplyWriteOverallComponent: Component<ApplyWriteOverallDependency> {
    var applyService: ApplyServiceProtocol {
        return dependency.applyService
    }
    
    var companyService: CompanyServiceProtocol {
        return CompanyService()
    }
    
    var stageService: StageServiceProtocolISOLDCODE {
        return StageServiceISOLDCODE()
    }
}

// MARK: - Builder
protocol ApplyWriteOverallBuildable: Buildable {
    func build(withListener listener: ApplyWriteOverallListener) -> ApplyWriteOverallRouting
}

final class ApplyWriteOverallBuilder: Builder<ApplyWriteOverallDependency>, ApplyWriteOverallBuildable {

    override init(dependency: ApplyWriteOverallDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ApplyWriteOverallListener) -> ApplyWriteOverallRouting {
        let component = ApplyWriteOverallComponent(dependency: dependency)
        let viewController = ApplyWriteOverallViewController()
        let interactor = ApplyWriteOverallInteractor(presenter: viewController)
        let applyWriteScheduleBuilder = WriteApplyScheduleBuilder(dependency: component)
        
        interactor.listener = listener
        
        return ApplyWriteOverallRouter(interactor: interactor, viewController: viewController, applyWriteScheduleBuilder: applyWriteScheduleBuilder)
    }
}
