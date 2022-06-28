//
//  ApplyEditBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import RIBs

protocol ApplyEditDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ApplyEditComponent: Component<ApplyEditDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    let apply: ApplyResponse?
    
    init(dependency: ApplyEditDependency, apply: ApplyResponse) {
        self.apply = apply
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol ApplyEditBuildable: Buildable {
    func build(withListener listener: ApplyEditListener, apply: ApplyResponse) -> ApplyEditRouting
}

final class ApplyEditBuilder: Builder<ApplyEditDependency>, ApplyEditBuildable {

    override init(dependency: ApplyEditDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ApplyEditListener, apply: ApplyResponse) -> ApplyEditRouting {
        let component = ApplyEditComponent(dependency: dependency, apply: apply)
        let viewController = ApplyEditViewController()
        let interactor = ApplyEditInteractor(presenter: viewController, apply: apply)
        interactor.listener = listener
        return ApplyEditRouter(interactor: interactor, viewController: viewController)
    }
}
