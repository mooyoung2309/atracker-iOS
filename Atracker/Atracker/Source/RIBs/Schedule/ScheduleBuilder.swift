//
//  ScheduleBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/20.
//

import RIBs

protocol ScheduleDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ScheduleComponent: Component<ScheduleDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ScheduleBuildable: Buildable {
    func build(withListener listener: ScheduleListener) -> ScheduleRouting
}

final class ScheduleBuilder: Builder<ScheduleDependency>, ScheduleBuildable {

    override init(dependency: ScheduleDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ScheduleListener) -> ScheduleRouting {
        let component = ScheduleComponent(dependency: dependency)
        let viewController = ScheduleViewController()
        let interactor = ScheduleInteractor(presenter: viewController)
        interactor.listener = listener
        return ScheduleRouter(interactor: interactor, viewController: viewController)
    }
}
