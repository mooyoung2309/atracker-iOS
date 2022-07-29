//
//  EditApplyOverallBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/05.
//

import RIBs

protocol EditApplyOverallDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class EditApplyOverallComponent: Component<EditApplyOverallDependency> {

    var applyService: ApplyServiceProtocol {
        return ApplyService()
    }
    
    var companyService: CompanyServiceProtocol {
        return CompanyService()
    }
}

// MARK: - Builder

protocol EditApplyOverallBuildable: Buildable {
    func build(withListener listener: EditApplyOverallListener, apply: Apply) -> EditApplyOverallRouting
}

final class EditApplyOverallBuilder: Builder<EditApplyOverallDependency>, EditApplyOverallBuildable {

    override init(dependency: EditApplyOverallDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: EditApplyOverallListener, apply: Apply) -> EditApplyOverallRouting {
        let component = EditApplyOverallComponent(dependency: dependency)
        let viewController = EditApplyOverallViewController()
        let interactor = EditApplyOverallInteractor(presenter: viewController, applyService: component.applyService, companyService: component.companyService, apply: apply)
        interactor.listener = listener
        return EditApplyOverallRouter(interactor: interactor, viewController: viewController)
    }
}
