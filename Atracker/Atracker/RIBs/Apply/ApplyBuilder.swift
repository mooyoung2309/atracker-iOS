//
//  ApplyBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs

protocol ApplyDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ApplyComponent: Component<ApplyDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ApplyBuildable: Buildable {
    func build(withListener listener: ApplyListener) -> ApplyRouting
}

final class ApplyBuilder: Builder<ApplyDependency>, ApplyBuildable {

    override init(dependency: ApplyDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ApplyListener) -> ApplyRouting {
        
        let component           = ApplyComponent(dependency: dependency)
        let viewController      = ApplyViewController()
        let service             = ApplyService()
        let interactor          = ApplyInteractor(presenter: viewController, service: service)
        let applyEditBuilder    = ApplyEditBuilder(dependency: component)
        let applyDetailBuilder  = ApplyDetailBuilder(dependency: component)
        
        interactor.listener = listener
        
        return ApplyRouter(interactor: interactor,
                           viewController: viewController,
                           applyEditBuilder: applyEditBuilder,
                           applyDetailBuilder: applyDetailBuilder)
    }
}
