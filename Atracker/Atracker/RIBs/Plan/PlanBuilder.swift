//
//  PlanBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs

protocol PlanDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class PlanComponent: Component<PlanDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol PlanBuildable: Buildable {
    func build(withListener listener: PlanListener) -> PlanRouting
}

final class PlanBuilder: Builder<PlanDependency>, PlanBuildable {

    override init(dependency: PlanDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: PlanListener) -> PlanRouting {
        let component = PlanComponent(dependency: dependency)
        let viewController = PlanViewController()
        let interactor = PlanInteractor(presenter: viewController)
        interactor.listener = listener
        return PlanRouter(interactor: interactor, viewController: viewController)
    }
}
