//
//  ApplyWriteBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import RIBs

protocol WriteApplyOverallDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class WriteApplyOverallComponent: Component<WriteApplyOverallDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    var companyService: CompanyServiceProtocol {
        return CompanyService()
    }
    
    var stageService: StageServiceProtocol {
        return StageService()
    }
}

// MARK: - Builder

protocol WriteApplyOverallBuildable: Buildable {
    func build(withListener listener: WriteApplyOverallListener) -> WriteApplyOverallRouting
}

final class WriteApplyOverallBuilder: Builder<WriteApplyOverallDependency>, WriteApplyOverallBuildable {

    override init(dependency: WriteApplyOverallDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: WriteApplyOverallListener) -> WriteApplyOverallRouting {
        let component = WriteApplyOverallComponent(dependency: dependency)
        let viewController = WriteApplyOverallViewController()
        let interactor = WriteApplyOverallInteractor(presenter: viewController, companyService: component.companyService, stageService: component.stageService)
        let writeApplyScheduleBuilder = WriteApplyScheduleBuilder(dependency: component)
        
        interactor.listener = listener
        
        return WriteApplyOverallRouter(interactor: interactor, viewController: viewController, writeApplyScheduleBuilder: writeApplyScheduleBuilder)
    }
}
