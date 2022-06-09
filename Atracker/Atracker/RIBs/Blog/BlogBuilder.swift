//
//  BlogBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs

protocol BlogDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class BlogComponent: Component<BlogDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol BlogBuildable: Buildable {
    func build(withListener listener: BlogListener) -> BlogRouting
}

final class BlogBuilder: Builder<BlogDependency>, BlogBuildable {

    override init(dependency: BlogDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: BlogListener) -> BlogRouting {
        let component = BlogComponent(dependency: dependency)
        let viewController = BlogViewController()
        let interactor = BlogInteractor(presenter: viewController)
        interactor.listener = listener
        return BlogRouter(interactor: interactor, viewController: viewController)
    }
}
