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
    var applyService: ApplyServiceProtocol {
        return ApplyService()
    }
    
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
        
        let component = ApplyComponent(dependency: dependency)
        let viewController = ApplyViewController()
        let interactor = ApplyInteractor(presenter: viewController, applyService: component.applyService)
        let applyWriteBuilder = WriteApplyOverallBuilder(dependency: component)
        let applyDetailBuilder = ApplyDetailBuilder(dependency: component)
        let myPageBuilder = MyPageBuilder(dependency: component)
        
        interactor.listener = listener
        
        return ApplyRouter(interactor: interactor, viewController: viewController, applyWriteBuilder: applyWriteBuilder, applyDetailBuilder: applyDetailBuilder, myPageBuilder: myPageBuilder)
    }
}
