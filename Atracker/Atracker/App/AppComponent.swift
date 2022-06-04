//
//  AppComponent.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/03.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {

    init() {
        super.init(dependency: EmptyComponent())
    }
}
