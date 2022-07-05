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

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol EditApplyOverallBuildable: Buildable {
    func build(withListener listener: EditApplyOverallListener) -> EditApplyOverallRouting
}

final class EditApplyOverallBuilder: Builder<EditApplyOverallDependency>, EditApplyOverallBuildable {

    override init(dependency: EditApplyOverallDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: EditApplyOverallListener) -> EditApplyOverallRouting {
        let component = EditApplyOverallComponent(dependency: dependency)
        let viewController = EditApplyOverallViewController()
        let interactor = EditApplyOverallInteractor(presenter: viewController)
        interactor.listener = listener
        return EditApplyOverallRouter(interactor: interactor, viewController: viewController)
    }
}
