//
//  EditApplyStageProgressBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/05.
//

import RIBs

protocol EditApplyStageProgressDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class EditApplyStageProgressComponent: Component<EditApplyStageProgressDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol EditApplyStageProgressBuildable: Buildable {
    func build(withListener listener: EditApplyStageProgressListener) -> EditApplyStageProgressRouting
}

final class EditApplyStageProgressBuilder: Builder<EditApplyStageProgressDependency>, EditApplyStageProgressBuildable {

    override init(dependency: EditApplyStageProgressDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: EditApplyStageProgressListener) -> EditApplyStageProgressRouting {
        let component = EditApplyStageProgressComponent(dependency: dependency)
        let viewController = EditApplyStageProgressViewController()
        let interactor = EditApplyStageProgressInteractor(presenter: viewController)
        interactor.listener = listener
        return EditApplyStageProgressRouter(interactor: interactor, viewController: viewController)
    }
}
