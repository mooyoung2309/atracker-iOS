//
//  TabBarBuilder.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/09.
//

import RIBs

protocol TabBarDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class TabBarComponent: Component<TabBarDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    var userService: UserServiceProtocol {
        return UserService()
    }
}

// MARK: - Builder

protocol TabBarBuildable: Buildable {
    func build(withListener listener: TabBarListener) -> TabBarRouting
}

final class TabBarBuilder: Builder<TabBarDependency>, TabBarBuildable {

    override init(dependency: TabBarDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TabBarListener) -> TabBarRouting {
        
        let component = TabBarComponent(dependency: dependency)
        let viewController = TabBarViewController()
        let interactor = TabBarInteractor(presenter: viewController)
        let blogBuilder = BlogBuilder(dependency: component)
        let applyBuilder = ApplyBuilder(dependency: component)
//        let myPageBuilder = MyPageBuilder(dependency: component)
        // FIXME: 리엑토 킷 수정 중
        let newMyPageBuilder = NewMyPageBuilder(dependency: component)
        let scheduleBuilder = ScheduleBuilder(dependency: component)
        
        interactor.listener = listener
        
        return TabBarRouter(interactor: interactor, viewController: viewController, blogBuilder: blogBuilder, applyBuilder: applyBuilder, myPageBuilder: newMyPageBuilder, scheduleBuilder: scheduleBuilder)
    }
}
