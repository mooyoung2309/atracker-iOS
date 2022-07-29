//
//  RootBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs

protocol RootDependency: Dependency {
    // Parent에 주입하는 것들
}

final class RootComponent: Component<RootDependency> {
    let rootViewController: RootViewController
    
    init(dependency: RootDependency, rootViewController: RootViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let viewController = RootViewController()
        let component = RootComponent(dependency: dependency, rootViewController: viewController)
        let interactor = RootInteractor(presenter: viewController)
        let signOutBuilder = SignOutBuilder(dependency: component)
        let signInBuilder = SignInBuilder(dependency: component)
        
        return RootRouter(interactor: interactor, viewController: viewController, signOutBuilder: signOutBuilder, signInBuilder: signInBuilder)
    }
}
